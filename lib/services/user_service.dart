import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final String collection = "users";

  // ==========================
  // Create User
  // ==========================

  Future<void> createUser(UserModel user) async {
    await _firestore
        .collection(collection)
        .doc(user.uid)
        .set(user.toMap());
  }

  // ==========================
  // Get User
  // ==========================

  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestore
        .collection(collection)
        .doc(uid)
        .get();

    if (!doc.exists) return null;

    return UserModel.fromMap(doc.data()!);
  }

  // ==========================
  // Check Email Exists
  // ==========================

  Future<bool> emailExists(String email) async {
    final result = await _firestore
        .collection(collection)
        .where(
          "email",
          isEqualTo: email.trim(),
        )
        .limit(1)
        .get();

    return result.docs.isNotEmpty;
  }

  // ==========================
  // Update User
  // ==========================

  Future<void> updateUser(UserModel user) async {
    await _firestore
        .collection(collection)
        .doc(user.uid)
        .update(user.toMap());
  }

  // ==========================
  // Delete User
  // ==========================

  Future<void> deleteUser(String uid) async {
    await _firestore
        .collection(collection)
        .doc(uid)
        .delete();
  }
}