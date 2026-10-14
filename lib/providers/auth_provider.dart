import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  bool _loading = false;
  bool get loading => _loading;

  String? _role;
  String? get role => _role;

  String? _error;
  String? get error => _error;

  User? get currentUser => _authService.currentUser;

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // =============================
  // CHECK EMAIL EXISTS
  // =============================

  Future<bool> checkEmailExists(String email) async {
    return await _userService.emailExists(email);
  }

  // =============================
  // REGISTER
  // =============================

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);

      final credential = await _authService.register(
        email: email,
        password: password,
      );

      final user = UserModel(
        uid: credential.user!.uid,
        name: "$firstName $lastName",
        email: email,
        phone: phone,
        image: "",
        role: "user",
        createdAt: Timestamp.now(),
      );

      await _userService.createUser(user);

      _role = "user";
      _error = null;

      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message;
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // =============================
  // LOGIN
  // =============================

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);

      final credential = await _authService.login(
        email: email,
        password: password,
      );

      final user =
          await _userService.getUser(
        credential.user!.uid,
      );

      _role = user?.role ?? "user";
      _error = null;

      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message;
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // =============================
  // GOOGLE LOGIN
  // =============================

  Future<bool> googleLogin() async {
    try {
      _setLoading(true);

      final credential =
          await _authService.signInWithGoogle();

      if (credential == null) {
        _setLoading(false);
        return false;
      }

      final existingUser =
          await _userService.getUser(
        credential.user!.uid,
      );

      if (existingUser == null) {
        final user = UserModel(
          uid: credential.user!.uid,
          name: credential.user!.displayName ?? "",
          email: credential.user!.email ?? "",
          phone: "",
          image: credential.user!.photoURL ?? "",
          role: "user",
          createdAt: Timestamp.now(),
        );

        await _userService.createUser(user);
      }

      final current =
          await _userService.getUser(
        credential.user!.uid,
      );

      _role = current?.role ?? "user";
      _error = null;

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // =============================
  // RESET PASSWORD
  // =============================

  Future<void> resetPassword(String email) async {
    await _authService.resetPassword(email);
  }
// =============================
// CONTINUE WITH EMAIL
// =============================

Future<bool> continueWithEmail(String email) async {
  try {
    _setLoading(true);

    final exists = await _userService.emailExists(email);

    _error = null;

    return exists;
  } catch (e) {
    _error = e.toString();
    return false;
  } finally {
    _setLoading(false);
  }
}
  // =============================
  // LOGOUT
  // =============================

  Future<void> logout() async {
    await _authService.logout();

    _role = null;
    _error = null;

    notifyListeners();
  }
}