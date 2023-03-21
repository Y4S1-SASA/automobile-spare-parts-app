import 'package:automobile_spare_parts_app/view/screens/auth/provider/user.dart';
import 'package:flutter/foundation.dart';

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
  }

  void logout() {
    _user = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}

