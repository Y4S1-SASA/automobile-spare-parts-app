import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  // forget pw state
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool visible = false;
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Color.fromARGB(255, 255, 255, 255),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.70,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Forgot Password",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 24,
                              fontFamily: "Inter",
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 10,
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
                              hintText: 'Enter your account email address',
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
                              // validate email
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please enter a valid email");
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 40,
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
                                ReqForgotPassword(emailController.text);
                                setState(() {
                                  visible = true;
                                });
                              },
                              child: Text(
                                "Request Change Password",
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
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                side: BorderSide(
                                  color: Color.fromARGB(255, 6, 84, 79),
                                ),
                              ),
                              elevation: 2.0,
                              height: 45,
                              minWidth: 270,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 6, 84, 79),
                                  fontFamily: 'Inter',
                                ),
                              ),
                              color: Color.fromARGB(255, 255, 255, 255),
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
      ),
    );
  }

  // request password reset email
  void ReqForgotPassword(String email) async {
    if (_formkey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg:
              "Password Reset link sent to your email. Please check your email",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 4,
          backgroundColor: Color.fromARGB(255, 4, 154, 89),
          textColor: Colors.white,
          fontSize: 16.0);
      await _auth
          .sendPasswordResetEmail(email: email)
          .then((uid) => {
                // after req redirect to login
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()))
              })
          .catchError((e) {
        Fluttertoast.showToast(
            msg: e,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 4,
            backgroundColor: const Color.fromARGB(255, 233, 23, 23),
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
  }
}
