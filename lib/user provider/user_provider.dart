import 'package:flutter/material.dart';

import '../firebase/auth.dart';
import '../model/user_model.dart';

class UserProvider with ChangeNotifier {
  Users? _user;

  final _authmethods = AuthMethods();

  Users get getuser => _user!;

  Future<void> refreshUser() async {
    Users user = await _authmethods.getUserDetails();

    _user = user;
    notifyListeners();
  }
}
