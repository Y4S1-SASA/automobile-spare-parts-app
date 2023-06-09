import 'dart:io';
import 'package:automobile_spare_parts_app/view/screens/auth/provider/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/profile/user-profile.dart';
import 'package:flutter/material.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

// edit state
class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _lastName;
  String? _imageUrl;

  // image picker
  Future<void> _pickImage() async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      final userProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = userProvider.user!.userId;

      // Upload the image file to Firebase Storage
      final storageRef =
          FirebaseStorage.instance.ref().child('users/$userId/profile_pic');
      final task = storageRef.putFile(File(imageFile.path));

      // progress indicator alert
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text('Uploading...'),
          content: StreamBuilder<TaskSnapshot>(
            stream: task.snapshotEvents,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                final progress =
                    snapshot.data!.bytesTransferred / snapshot.data!.totalBytes;
                return LinearProgressIndicator(value: progress);
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      );

      // sync url
      final snapshot =
          await task.whenComplete(() => Navigator.of(context).pop());
      final imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // auth provider
    final userProvider = Provider.of<AuthProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
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
                      "Update Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 24,
                        fontFamily: "Inter",
                      ),
                    ),
                  ),
                  SizedBox(
                      width: 48), // Add some spacing to the right of the text
                ],
              ),

              SizedBox(
                height: 20,
              ),

              CircleAvatar(
                radius: 50,
                backgroundImage: user?.imageUrl == null
                    ? AssetImage(
                        'assets/users/profile-icon.png',
                        // width: 120,
                        // height: 120,
                      ) as ImageProvider<Object>?
                    : NetworkImage(user!.imageUrl) as ImageProvider<Object>?,
                child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: _pickImage,
                ),
              ),

              SizedBox(height: 30),

              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "First Name",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 63, 63, 63),
                    fontSize: 10,
                    fontFamily: "Inter",
                  ),
                ),
              ),

              SizedBox(
                height: 2,
              ),

// edit firstname
              TextFormField(
                initialValue: user?.firstName ?? '',
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 235, 235),
                  hintText: 'Enter your first name',
                  enabled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 14.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: new BorderSide(
                        color: Color.fromARGB(255, 217, 217, 217)),
                    borderRadius: new BorderRadius.circular(8),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(
                        color: Color.fromARGB(255, 217, 217, 217)),
                    borderRadius: new BorderRadius.circular(8),
                  ),
                ),
                // validate firstname
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'First Name is required!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _firstName = value;
                },
              ),

              SizedBox(
                height: 20,
              ),

              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Last Name",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 63, 63, 63),
                    fontSize: 10,
                    fontFamily: "Inter",
                  ),
                ),
              ),

              SizedBox(
                height: 2,
              ),

              // edit lastname
              TextFormField(
                initialValue: user?.lastName ?? '',
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 235, 235),
                  hintText: 'Last Name is required!',
                  enabled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 14.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: new BorderSide(
                        color: Color.fromARGB(255, 217, 217, 217)),
                    borderRadius: new BorderRadius.circular(8),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(
                        color: Color.fromARGB(255, 217, 217, 217)),
                    borderRadius: new BorderRadius.circular(8),
                  ),
                ),
                // validate lastname
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Last Name is required!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _lastName = value;
                },
              ),

              SizedBox(height: 20),

              // save button
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                elevation: 2.0,
                height: 45,
                minWidth: 270,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // trigger updateUser in provider
                    final updatedUser = AuthUser(
                      // passing data
                      userId: user?.userId ?? '',
                      email: user?.email ?? '',
                      firstName: _firstName ?? user?.firstName ?? '',
                      lastName: _lastName ?? user?.lastName ?? '',
                      imageUrl: _imageUrl ?? user?.imageUrl ?? '',
                    );

                    // trigering point
                    userProvider.updateUser(updatedUser);
                    // go back
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontFamily: 'Inter',
                  ),
                ),
                color: Color.fromARGB(255, 6, 84, 79),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
