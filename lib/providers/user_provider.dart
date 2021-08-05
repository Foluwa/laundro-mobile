import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  String? _jwt;

  /// Set current user
  void setUserJwt(jwt) {
    _jwt = jwt;
    notifyListeners();
  }

  /// Set current user
  void setCurrentUser(user) {
    print('SETTING USER $user');
    _user = user;
    notifyListeners();
  }

  User? get getUser => _user;
  String? get getJwt => _jwt;
}
