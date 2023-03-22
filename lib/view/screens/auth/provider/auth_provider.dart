import 'package:automobile_spare_parts_app/view/screens/auth/provider/user.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';

// created AuthProvider to get logged user data
class AuthProvider with ChangeNotifier {
  AuthUser? _user;
  bool _isLoggedIn = false;

  AuthUser? get user => _user;

  bool get isLoggedIn => _isLoggedIn;

  void setUser(AuthUser user) {
    _user = user;
    _isLoggedIn = true;
    notifyListeners();
    print('User data: $user');
  }

  void logout() {
    _user = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  //get user data
  void getAuthUserData(String userId) async {
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users').child(userId);
    DataSnapshot snapshot =
        await userRef.once().then((event) => event.snapshot);
    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
    // added user data to be included in setUser
    AuthUser user = AuthUser(
      firstName: data['firstName'],
      lastName: data['lastName'],
      imageUrl: data['imageUrl'],
      email: data['email'],
      userId: userId,
    );
    setUser(user);
  }
}
