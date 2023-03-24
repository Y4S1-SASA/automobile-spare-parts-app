import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  _RegisterScreenState();

  bool showProgress = false;
  bool visible = false;
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpassController =
      new TextEditingController();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;
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
  Future<void> _showImagePicker() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Text(
                          "Register Now",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 24,
                            fontFamily: "Inter",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _showImagePicker();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(300),
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color.fromARGB(255, 6, 84, 79),
                                  width: 1,
                                ),
                              ),
                              child: _imageFile == null
                                  ? Image.asset(
                                      'assets/users/profile-icon.png',
                                      width: 120,
                                      height: 120,
                                    )
                                  : Image.file(
                                      _imageFile!,
                                      height: 120,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
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
                        TextFormField(
                          controller: firstNameController,
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
                          // validate first name to required
                          validator: (value) {
                            if (value!.length == 0) {
                              return "First Name cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.name,
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
                        TextFormField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 235, 235, 235),
                            hintText: 'Enter your last name',
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
                          // validate last name to required
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Last Name cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Email",
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
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 235, 235, 235),
                            hintText: 'Enter your email address',
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
                          // validate email to required
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Password",
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
                        TextFormField(
                          obscureText: _isObscure,
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            filled: true,
                            fillColor: Color.fromARGB(255, 235, 235, 235),
                            hintText: 'Enter a strong password',
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
                          // validate password
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            // check charactors
                            if (value.length < 6) {
                              return "Password must contain at least 6 characters";
                            }
                            // check uppercase
                            RegExp upperCaseRegExp = new RegExp(r'[A-Z]');
                            if (!upperCaseRegExp.hasMatch(value)) {
                              return "Password must contain at least one uppercase letter";
                            }
                            // check lowercase
                            RegExp lowerCaseRegExp = new RegExp(r'[a-z]');
                            if (!lowerCaseRegExp.hasMatch(value)) {
                              return "Password must contain at least one lowercase letter";
                            }
                            // check special character
                            RegExp specialCharRegExp =
                                new RegExp(r'[!@#\$&*~]');
                            if (!specialCharRegExp.hasMatch(value)) {
                              return "Password must contain at least one special character (!@#\$&*~)";
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Confirm Password",
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
                        TextFormField(
                          obscureText: _isObscure2,
                          controller: confirmpassController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure2
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                }),
                            filled: true,
                            fillColor: Color.fromARGB(255, 235, 235, 235),
                            hintText: 'Re-enter your password',
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
                          // confirm password
                          validator: (value) {
                            if (confirmpassController.text !=
                                passwordController.text) {
                              return "Password did not match";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          //keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(fontSize: 16),
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 6, 84, 79),
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Add your navigation logic here
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            elevation: 2.0,
                            height: 45,
                            minWidth: 270,
                            onPressed: () {
                              setState(() {
                                showProgress = true;
                              });
                              register(
                                firstNameController.text,
                                lastNameController.text,
                                emailController.text,
                                passwordController.text,
                              );
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'Inter',
                              ),
                            ),
                            color: Color.fromARGB(255, 6, 84, 79),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: visible,
                            child: Container(
                                child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 6, 84, 79),
                            ))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // user registration
  register(
      String firstName, String lastName, String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        visible = true;
        // auth credentials
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // store user data in realtime db
        String userId = userCredential.user!.uid;
        String imageUrl = await _uploadImageToFirebase(context);
        DatabaseReference usersRef =
            FirebaseDatabase.instance.reference().child('users');
        Map<String, dynamic> newUser = {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'imageUrl': imageUrl,
        };
        // set new user in db
        usersRef.child(userId).set(newUser);
        // redirect
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
      visible = true;
      CircularProgressIndicator();
    }
  }
}
