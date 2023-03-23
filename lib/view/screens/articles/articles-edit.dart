import 'package:automobile_spare_parts_app/data/models/article.modal.dart';
import 'package:automobile_spare_parts_app/view/base/footer.widget.dart';
import 'package:automobile_spare_parts_app/view/base/heading.widget.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/profile/user-profile.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/place-order.dart';
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

class EditArticle extends StatefulWidget {
  final ArticleModal article;
  EditArticle({Key? key, required this.article}) : super(key: key);
  
  @override
  State<EditArticle> createState() => _EditArticleState();
}

class _EditArticleState extends State<EditArticle> {
  late ArticleModal oldArticle;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _tagsController;
    int _selectedAppBarIconIndex = 1;

    final databaseRef = FirebaseDatabase.instance.reference();


  @override
  void initState() {
    super.initState();
    oldArticle = ArticleModal(
      key: widget.article.key, 
      title: widget.article.title, 
      description: widget.article.description, 
      tags: widget.article.tags,
      imageUrl: widget.article.imageUrl, 
      ownerEmail: widget.article.ownerEmail
      );
    _titleController = TextEditingController(text: widget.article.title);
    _descriptionController = TextEditingController(text: widget.article.description);
    _tagsController = TextEditingController(text: widget.article.tags.join(","));


  }


Future<void> deleteArticle(String articleId) async {
  await databaseRef.child('articles').child(articleId).remove();
  print('Article deleted successfully.');
}

Future<void> updateArticle(ArticleModal article) async {
  final Map<String, dynamic> updateData = {
    'title': article.title,
    'description': article.description,
    'tags': article.tags,
    'imageUrl': article.imageUrl,
    'ownerEmail': article.ownerEmail
  };

  await databaseRef.child('articles').child(oldArticle.key ?? "").update(updateData);
  print('Article updated successfully.');
}

  void _appBarIconTap(int index) {
    setState(() {
      _selectedAppBarIconIndex = index;
    });
  }


  File? _imageFile;
  final picker = ImagePicker();

  // Loads image image from source
  Future<void> _getImageFromSource(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
    Navigator.of(context).pop();
  }

  // Image selecting dialog
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
    if (_imageFile == null) return "null";

    // Create a unique filename for the image
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Upload the image to Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child('images/$fileName');
    final uploadTask = storageRef.putFile(_imageFile!);
    final snapshot = await uploadTask.whenComplete(() {});
    final imageUrl = await snapshot.ref.getDownloadURL();

    return imageUrl;
  }

  // saves article in firebase realitime database
  Future<void> _saveArticle(BuildContext context) async {
    String? loggedInUserEmail = FirebaseAuth.instance.currentUser?.email;

    if (loggedInUserEmail != null) {
      // Show progress dialog
      showDialog(
        context: context,
        builder: (BuildContext context) => const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );

      String imageUrl = oldArticle.imageUrl;

      if (_imageFile != null) {
        imageUrl = await _uploadImageToFirebase(context);
      }
      
      List<String> tagsList = _tagsController.text.split(",");
      ArticleModal article = ArticleModal(
          title: _titleController.text,
          description: _descriptionController.text,
          tags: tagsList,
          imageUrl: imageUrl,
          ownerEmail: loggedInUserEmail);

      await updateArticle(article);
      
      // Hide progress dialog
      Navigator.of(context).pop();

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Article updated successfully!')),
      );
    } else {
      print("not logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Article'),
      ),
      body: SingleChildScrollView(
        child: Container(
          // articlescreatebq2 (10:678)
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffececec)),
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // autogroupyq5usGk (2G1d1Cw1Lk4a1AbVs8yQ5u)
                padding:
                    EdgeInsets.fromLTRB(0 * fem, 21.79 * fem, 0 * fem, 0 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Heading(),
                    GestureDetector(
                      onTap: () async {
                        await _showImageSourceSelectionDialog();
                      },
                      child: Container(
                        // group47wA8 (10:1628)
                        margin: EdgeInsets.fromLTRB(
                            9 * fem, 0 * fem, 0 * fem, 47.64 * fem),
                        width: 242 * fem,
                        height: 149 * fem,
                        child: _imageFile == null
                            ? Image.network(
                                oldArticle.imageUrl,
                                width: 242 * fem,
                                height: 149 * fem,
                              )
                            : Image.file(
                                _imageFile!,
                                height: 200,
                              ),
                      ),
                    ),
                    Container(
                      // group40rH6 (10:1178)
                      margin: EdgeInsets.fromLTRB(
                          32 * fem, 0 * fem, 32 * fem, 179 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // autogroup8pfrysW (2G1dHnHip4VR5KhvaR8pfR)
                            padding: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 22 * fem),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // inputtextW6k (10:805)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0.41 * fem, 22 * fem),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // titleqep (10:806)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 8.88 * fem),
                                        child: Text(
                                          'Title',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 12 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2125 * ffem / fem,
                                            color: Color(0xff666666),
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
                                              BorderRadius.circular(8 * fem),
                                        ),
                                        child: TextFormField(
                                          controller: _titleController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 20.0,
                                                    horizontal: 14.0),
                                            hintText:
                                                'Enter title for the article',
                                            hintStyle: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 16 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.2125 * ffem / fem,
                                              color: Color(0xffbdbdbd),
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 16 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2125 * ffem / fem,
                                            color: Color(0xff666666),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // inputtext1hi (10:808)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0.41 * fem, 0 * fem),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // descriptionk9W (10:809)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 8.52 * fem),
                                        child: Text(
                                          'Description',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 12 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2125 * ffem / fem,
                                            color: Color(0xff666666),
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
                                              BorderRadius.circular(8 * fem),
                                        ),
                                        child: TextFormField(
                                          controller: _descriptionController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 20.0,
                                                    horizontal: 14.0),
                                            hintText:
                                                'Enter a description for the article',
                                            hintStyle: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 16 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.2125 * ffem / fem,
                                              color: Color(0xffbdbdbd),
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 16 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2125 * ffem / fem,
                                            color: Color(0xff666666),
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
                            // group39LNc (10:1172)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 40 * fem),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // tagsgBa (10:1173)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 9 * fem),
                                  child: Text(
                                    'Tags',
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 12 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2125 * ffem / fem,
                                      color: Color(0xff666666),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xffe7e7e7)),
                                    color: Color(0xfff6f6f6),
                                    borderRadius:
                                        BorderRadius.circular(8 * fem),
                                  ),
                                  child: TextFormField(
                                    controller: _tagsController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 14.0),
                                      hintText:
                                          'Enter tags separated by commas',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 16 * ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.2125 * ffem / fem,
                                        color: Color(0xffbdbdbd),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2125 * ffem / fem,
                                      color: Color(0xff666666),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // group6fJQ (10:1168)
                            margin: EdgeInsets.fromLTRB(
                                55 * fem, 0 * fem, 56 * fem, 0 * fem),
                            width: double.infinity,
                            height: 45 * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30 * fem),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                await _saveArticle(context);
                              },
                              child: Container(
                                // group5CJL (10:1169)
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xff5db075),
                                  borderRadius: BorderRadius.circular(30 * fem),
                                ),
                                child: Center(
                                  child: Text(
                                    'Update Article',
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 18 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.3333333333 * ffem / fem,
                                      letterSpacing: 0.150000006 * fem,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // group6fJQ (10:1168)
                            margin: EdgeInsets.fromLTRB(
                                55 * fem, 8 * fem, 56 * fem, 0 * fem),
                            width: double.infinity,
                            height: 45 * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30 * fem),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                await _saveArticle(context);
                              },
                              child: Container(
                                // group5CJL (10:1169)
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 214, 120, 13),
                                  borderRadius: BorderRadius.circular(30 * fem),
                                ),
                                child: Center(
                                  child: Text(
                                    'Delete Article',
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 18 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.3333333333 * ffem / fem,
                                      letterSpacing: 0.150000006 * fem,
                                      color: Color(0xffffffff),
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
            ],
          ),
        ),
      ),
            bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Color(0xff5db075),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: _selectedAppBarIconIndex == 0
                  ? Image.asset('assets/appbar/article_filled.png')
                  : Image.asset('assets/appbar/article.png'),
              onPressed: () {
                _appBarIconTap(0);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => EditArticle(articleId: "2",)),
                // );
              },
            ),
            IconButton(
              icon: _selectedAppBarIconIndex == 1
                  ? Image.asset('assets/appbar/market_filled.png')
                  : Image.asset('assets/appbar/market.png'),
              onPressed: () => _appBarIconTap(1),
            ),
            IconButton(
              icon: _selectedAppBarIconIndex == 2
                  ? Image.asset('assets/appbar/reservation_filled.png')
                  : Image.asset('assets/appbar/reservation.png'),
              onPressed: () {
                _appBarIconTap(2);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlaceOrder()),
                );
              },
            ),
            IconButton(
              icon: _selectedAppBarIconIndex == 3
                  ? Image.asset('assets/appbar/profile_filled.png')
                  : Image.asset('assets/appbar/profile.png'),
              onPressed: () {
                _appBarIconTap(3);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ],
        ),
      )
    );
  }
}
