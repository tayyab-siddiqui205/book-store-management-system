import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../services/category_service.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService _categoryService = CategoryService();

  //==================================================
  // SERVICE
  //==================================================

  CategoryService get service => _categoryService;

  //==================================================
  // LOADING
  //==================================================

  bool _loading = false;

  bool get loading => _loading;

  //==================================================
  // SEARCH
  //==================================================

  String _searchText = "";

  String get searchText => _searchText;

  void onSearch(String value) {
    _searchText = value;
    notifyListeners();
  }

  //==================================================
  // FIREBASE CRUD
  //==================================================

  Future<void> addCategory(
    CategoryModel category,
  ) async {
    _loading = true;
    notifyListeners();

    try {
      final exists =
          await _categoryService.categoryExists(
        category.name,
      );

      if (exists) {
        throw Exception(
          "Category already exists.",
        );
      }

      await _categoryService.addCategory(
        category,
      );
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> updateCategory(
    CategoryModel category,
  ) async {
    _loading = true;
    notifyListeners();

    try {
      await _categoryService.updateCategory(
        category,
      );
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> deleteCategory(
    String id,
  ) async {
    _loading = true;
    notifyListeners();

    try {
      await _categoryService.deleteCategory(id);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    _loading = false;
    notifyListeners();
  }

  //==================================================
  // STREAMS
  //==================================================

  get allCategories =>
      _categoryService.getCategories();

  get activeCategories =>
      _categoryService.getActiveCategories();

  searchCategories(String keyword) =>
      _categoryService.searchCategory(
        keyword,
      );

  //==================================================
  // HELPERS
  //==================================================

  Future<int> totalCategories() async {
    return await _categoryService
        .getTotalCategories();
  }

  Future<bool> categoryExists(
    String name,
  ) async {
    return await _categoryService
        .categoryExists(name);
  }
}