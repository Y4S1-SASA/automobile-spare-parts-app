import 'package:automobile_spare_parts_app/data/models/article.modal.dart';
import 'package:automobile_spare_parts_app/view/base/footer.widget.dart';
import 'package:automobile_spare_parts_app/view/base/heading.widget.dart';
import 'package:automobile_spare_parts_app/view/screens/articles/articles-list.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/profile/user-profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import '/utils.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Scene extends StatefulWidget {
  @override
  State<Scene> createState() => _SceneState();
}

class _SceneState extends State<Scene> {
  
  //Texting input controllers
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _tagsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  final picker = ImagePicker();

  // Loads images from camera or gallery
  Future<void> _getImageFromSource(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
    Navigator.of(context).pop();
  }

  // Image selecting dialog box
  Future<void> _showImageSourceSelectionDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () {
                    _getImageFromSource(ImageSource.gallery);
                  },
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () {
                    _getImageFromSource(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // uploads image to firebase storage
  Future<String> _uploadImageToFirebase(BuildContext context) async {

    // If an image is not seleceted. default image will be returned
    if (_imageFile == null) return "https://icon-library.com/images/no-image-icon/no-image-icon-0.jpg";

    // Create a filename for the image
    final imageFileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Upload the image to Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child('images/$imageFileName');
    final uploadTask = storageRef.putFile(_imageFile!);
    final snapshot = await uploadTask.whenComplete(() {});
    final imageUrl = await snapshot.ref.getDownloadURL();

    return imageUrl;
  }

  // saves article in firebase realitime database
  Future<void> _saveArticle(BuildContext context) async {

    // Currenlty logged in users id
    String? loggedInUserUid = FirebaseAuth.instance.currentUser?.uid;

    // Check form validations before submit
    if (_formKey.currentState!.validate()) {

        // Show progress dialog
        showDialog(
          context: context,
          builder: (BuildContext context) => const Center(
            child: CircularProgressIndicator(),
          ),
          barrierDismissible: false,
        );

        String imageUrl = await _uploadImageToFirebase(context);
        List<String> tagsList = _tagsController.text.split(",");
        ArticleModal article = ArticleModal(
            title: _titleController.text,
            description: _descriptionController.text,
            tags: tagsList,
            imageUrl: imageUrl,
            ownerUid: loggedInUserUid ?? "null");

        // Generate a new push key for the article
        final articleRef =
            FirebaseDatabase.instance.reference().child('articles').push();

        // Write the article to the Realtime Database
        await articleRef.set({
          'title': article.title,
          'description': article.description,
          'tags': article.tags,
          'imageUrl': article.imageUrl,
          'ownerUid': article.ownerUid
        });
        
        // Hide progress dialog
        Navigator.of(context).pop();

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Article created successfully!')),
        );
        Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 50),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffececec)),
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Create Article",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 24,
                        fontFamily: "Inter",
                      ),
                    ),
                  ),
                  SizedBox(width: 48),
                ],
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await _showImageSourceSelectionDialog();
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 200,
                          child: _imageFile == null
                              ? Image.asset('assets/page-1/images/group-47.png',
                                  width: 250, height: 250)
                              : Image.file(
                                  _imageFile!,
                                  height: 250,
                                ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 29),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 18),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 18),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 7),
                                          child: Text(
                                            'Title',
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Color.fromARGB(
                                                  255, 63, 63, 63),
                                              fontSize: 10,
                                              fontFamily: "Inter",
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter a title';
                                              }
                                              if (RegExp(r'^[0-9]+$')
                                                  .hasMatch(value)) {
                                                return 'Title cannot contain numbers';
                                              }
                                              return null;
                                            },
                                            controller: _titleController,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color.fromARGB(
                                                  255, 235, 235, 235),
                                              hintText: 'Enter a title',
                                              enabled: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20.0,
                                                      horizontal: 14.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 217, 217, 217)),
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        8),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 217, 217, 217)),
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        8),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 7),
                                          child: Text(
                                            'Description',
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Color.fromARGB(
                                                  255, 63, 63, 63),
                                              fontSize: 10,
                                              fontFamily: "Inter",
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xffe7e7e7)),
                                            color: Color(0xfff6f6f6),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter a description';
                                              }
                                              if (RegExp(r'^[0-9]+$')
                                                  .hasMatch(value)) {
                                                return 'Description cannot contain numbers';
                                              }
                                              return null;
                                            },
                                            controller: _descriptionController,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color.fromARGB(
                                                  255, 235, 235, 235),
                                              hintText: 'Enter a description',
                                              enabled: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20.0,
                                                      horizontal: 14.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 217, 217, 217)),
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        8),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 217, 217, 217)),
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        8),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 35),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 7),
                                    child: Text(
                                      'Tags',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Color.fromARGB(255, 63, 63, 63),
                                        fontSize: 10,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffe7e7e7)),
                                      color: Color(0xfff6f6f6),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: TextFormField(
                                      controller: _tagsController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter atleast one tag';
                                        }
                                        if (RegExp(r'^[0-9]+$')
                                            .hasMatch(value)) {
                                          return 'Tags cannot contain numbers';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 235, 235, 235),
                                        hintText:
                                            'Enter tags separated by commas',
                                        enabled: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 20.0,
                                                horizontal: 14.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromARGB(
                                                  255, 217, 217, 217)),
                                          borderRadius:
                                              new BorderRadius.circular(8),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color.fromARGB(
                                                  255, 217, 217, 217)),
                                          borderRadius:
                                              new BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 52),
                              width: double.infinity,
                              height: 43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(27),
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  await _saveArticle(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 6, 84, 79),
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Create',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
