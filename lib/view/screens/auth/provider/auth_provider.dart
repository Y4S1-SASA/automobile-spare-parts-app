import 'package:automobile_spare_parts_app/view/screens/auth/login.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/provider/user.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';

// created AuthProvider to get logged user data
class AuthProvider with ChangeNotifier {
  late SharedPreferences _prefs;

  // firebase auth and db instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  late final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final DatabaseReference _userDbRef =
      FirebaseDatabase.instance.reference().child('users');

  // check user availablility
  AuthUser? _user;
  // check if user logged in
  bool _isLoggedIn = false;

  // get authorized user
  AuthUser? get user => _user;

  // get logged in state
  bool get isLoggedIn => _isLoggedIn;

  // shared preferences not used to store user data
  AuthProvider({required SharedPreferences prefs}) {
    late SharedPreferences _prefs;
    AuthUser? _user;
    _prefs = prefs;
    final userData = _prefs.getString('user');
    // check if user is null
    if (userData != null) {
      _user = AuthUser.fromJson(json.decode(userData));
    }
  }

  // set logged user data to state
  void setUser(AuthUser user) {
    _user = user;
    _isLoggedIn = true;
    // notify the listeners
    notifyListeners();
    // print user data in console
    print('User data: $user');
  }

  // user logout
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    _user = null;
    // _prefs.setString('user', json.encode(_user!.toJson()));
    notifyListeners();
    // Login success redirect to login screen
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  //get authorized user data
  void getAuthUserData(String userId) async {
    // db ref
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users').child(userId);
    DataSnapshot snapshot =
        await userRef.once().then((event) => event.snapshot);
    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
    // user data initialized to state
    AuthUser user = AuthUser(
      firstName: data['firstName'],
      lastName: data['lastName'],
      imageUrl: data['imageUrl'],
      email: data['email'],
      userId: userId,
    );
    setUser(user);
  }

  // update user
  Future<void> updateUser(AuthUser user) async {
    final userRef =
        FirebaseDatabase.instance.reference().child('users/${user.userId}');
        // updating data
    await userRef.update({
      'firstName': user.firstName,
      'lastName': user.lastName,
      'imageUrl': user.imageUrl,
    });
    // update state and notify
    _user = user;
    notifyListeners();
  }

  // delete user
  Future<void> deleteUser(BuildContext context) async {
    final confirmation = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account Permanently'),
        content: Text(
            'Are you sure you want to delete your account permanently? This action cannot be undo.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            // confirm remove user by id
            onPressed: () async {
              await _userDbRef.child(_firebaseAuth.currentUser!.uid).remove();
              await _firebaseAuth.currentUser!.delete();
              Navigator.of(context).pop(true);
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmation == true) {
      // if confirmer user need to signed out and redirected to signin
      await _firebaseAuth.signOut();
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  // Future<void> deleteUser(BuildContext context) async {
  //   try {
  //     // Delete user data from Realtime Database
  //     await _database.child('users/${_user!.userId}').remove();

  //     // Delete user from Authentication
  //     User? currentUser = _auth.currentUser;
  //     if (currentUser != null) {
  //       await currentUser.delete();
  //     }

  //     // Clear the AuthProvider user data
  //     _user = null;
  //     notifyListeners();

  //     // Navigate to the login screen
  //     Navigator.of(context).pushReplacementNamed('/login');
  //   } catch (error) {
  //     // Handle the error
  //     print('Failed to delete user: $error');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to delete user')),
  //     );
  //   }
  // }
}
