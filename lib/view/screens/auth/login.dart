import 'package:automobile_spare_parts_app/view/screens/auth/provider/auth_provider.dart';
import 'package:automobile_spare_parts_app/view/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'forgot-password.dart';
import 'register.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/provider/user.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  // login state
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 24,
                            fontFamily: "Inter",
                          ),
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
                          onSaved: (value) {
                            emailController.text = value!;
                          },
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
                          obscureText: _isObscure3,
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure3
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure3 = !_isObscure3;
                                  });
                                }),
                            filled: true,
                            fillColor: Color.fromARGB(255, 235, 235, 235),
                            hintText: 'Enter your password',
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
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                          //keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(fontSize: 16),
                            children: [
                              TextSpan(
                                text: 'Register',
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
                                          builder: (context) => RegisterScreen()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPasswordScreen()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 6, 84, 79),
                                fontSize: 13,
                                fontFamily: "Inter",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          elevation: 2.0,
                          height: 45,
                          minWidth: 270,
                          onPressed: () {
                            setState(() {
                              visible = true;
                            });
                            logIn(
                                emailController.text, passwordController.text);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'Inter',
                            ),
                          ),
                          color: Color.fromARGB(255, 6, 84, 79),
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

  // request log in using email and password
  void logIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // init user id
        String userId = userCredential.user!.uid;
        // provider to get auth user data
        Provider.of<AuthProvider>(context, listen: false).getAuthUserData(userId);
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

}