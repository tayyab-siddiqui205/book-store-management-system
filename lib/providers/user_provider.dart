import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  UserModel? _user;

  UserModel? get user => _user;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> loadUser(String uid) async {
    _loading = true;
    notifyListeners();

    _user = await _userService.getUser(uid);

    _loading = false;
    notifyListeners();
  }

  Future<void> refresh(String uid) async {
    _user = await _userService.getUser(uid);
    notifyListeners();
  }

  Future<void> updateUser(UserModel user) async {
    await _userService.updateUser(user);

    _user = user;

    notifyListeners();
  }

  void clear() {
    _user = null;
    notifyListeners();
  }
}