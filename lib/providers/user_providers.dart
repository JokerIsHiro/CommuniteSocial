import 'package:flutter/material.dart';

import '../model/user.dart';
import '../resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final _authMethods = AutenticarMetodos();

  User get getUser => _user!;

  Future<void> refreshUser() async{
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}