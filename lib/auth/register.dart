import 'dart:io';
import 'package:flutter/gestures.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

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
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 24,
                            fontFamily: "Inter",
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("please enter valid password min. 6 character");
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
                                  color: Color.fromARGB(255, 58, 140, 54),
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
                            color: Color.fromARGB(255, 58, 140, 54),
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
                              color: Color.fromARGB(255, 58, 140, 54),
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

  // register req
  register(
      String firstName, String lastName, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String userId = userCredential.user!.uid;
      DatabaseReference usersRef =
          FirebaseDatabase.instance.reference().child('users');
      Map<String, dynamic> newUser = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };
      usersRef.child(userId).set(newUser);
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
    CircularProgressIndicator();
  }

  // firestore code
//   register(String firstName, String lastName, String email, String password) async {
//   if (_formkey.currentState!.validate()) {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       // Add first name and last name to user profile
//       await userCredential.user?.updateProfile(displayName: '$firstName $lastName');
//       await userCredential.user?.reload();
//       // Save additional user data to Firestore or Realtime Database
//       await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
//         'firstName': firstName,
//         'lastName': lastName,
//         'email': email,
//       });
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (_) => LoginScreen(),
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
}
