import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category_model.dart';
import 'firestore_service.dart';

class CategoryService {
  final FirestoreService _firestoreService = FirestoreService();

  FirebaseFirestore get firestore => _firestoreService.firestore;

  CollectionReference<Map<String, dynamic>> get categoriesRef =>
      firestore.collection("categories");

  //====================================================
  // ADD CATEGORY
  //====================================================

  Future<void> addCategory(CategoryModel category) async {
    try {
      await categoriesRef.doc(category.id).set({
        ...category.toJson(),
        "createdAt": FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception(
        e.message ?? "Unable to add category.",
      );
    } catch (_) {
      throw Exception(
        "Something went wrong while adding category.",
      );
    }
  }

  //====================================================
  // UPDATE CATEGORY
  //====================================================

  Future<void> updateCategory(
    CategoryModel category,
  ) async {
    try {
      await categoriesRef
          .doc(category.id)
          .update(category.toJson());
    } on FirebaseException catch (e) {
      throw Exception(
        e.message ?? "Unable to update category.",
      );
    } catch (_) {
      throw Exception(
        "Something went wrong while updating category.",
      );
    }
  }

  //====================================================
  // DELETE CATEGORY
  //====================================================

  Future<void> deleteCategory(String id) async {
    try {
      await categoriesRef.doc(id).delete();
    } on FirebaseException catch (e) {
      throw Exception(
        e.message ?? "Unable to delete category.",
      );
    } catch (_) {
      throw Exception(
        "Something went wrong while deleting category.",
      );
    }
  }

  //====================================================
  // ALL CATEGORIES
  //====================================================

  Stream<QuerySnapshot<Map<String, dynamic>>>
      getCategories() {
    return categoriesRef
        .orderBy(
          "createdAt",
          descending: true,
        )
        .snapshots();
  }

  //====================================================
  // ACTIVE CATEGORIES
  //====================================================

  Stream<QuerySnapshot<Map<String, dynamic>>>
      getActiveCategories() {
    return categoriesRef
        .where(
          "active",
          isEqualTo: true,
        )
        .orderBy(
          "createdAt",
          descending: true,
        )
        .snapshots();
  }

  //====================================================
  // SEARCH CATEGORY
  //====================================================

  Stream<QuerySnapshot<Map<String, dynamic>>>
      searchCategory(String keyword) {
    if (keyword.trim().isEmpty) {
      return getCategories();
    }

    return categoriesRef
        .orderBy("name")
        .startAt([keyword])
        .endAt(["$keyword\uf8ff"])
        .snapshots();
  }

  //====================================================
  // GET SINGLE CATEGORY
  //====================================================

  Future<DocumentSnapshot<Map<String, dynamic>>>
      getCategoryById(String id) async {
    return await categoriesRef.doc(id).get();
  }

  //====================================================
  // CHECK CATEGORY EXISTS
  //====================================================

  Future<bool> categoryExists(
    String name,
  ) async {
    final snapshot = await categoriesRef
        .where(
          "name",
          isEqualTo: name,
        )
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  //====================================================
  // TOTAL CATEGORIES
  //====================================================

  Future<int> getTotalCategories() async {
    final snapshot = await categoriesRef.get();
    return snapshot.docs.length;
  }
}