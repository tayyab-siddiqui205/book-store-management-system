import 'dart:async';

import 'package:flutter/material.dart';

import '../models/book_model.dart';
import '../repositories/book_repository.dart';
import '../services/book_service.dart';

class BookProvider extends ChangeNotifier {
  final BookRepository _repository = BookRepository();
  final BookService _bookService = BookService();

  //==================================================
  // FIRESTORE
  //==================================================

  BookService get service => _bookService;

  //==================================================
  // GOOGLE BOOKS
  //==================================================

  List<BookModel> _googleBooks = [];

  List<BookModel> get googleBooks => _googleBooks;

  //==================================================
  // LOADING
  //==================================================

  bool _loading = false;

  bool get loading => _loading;

  //==================================================
  // SEARCH
  //==================================================

  Timer? _debounce;

  String _searchText = "";

  String get searchText => _searchText;

  Future<void> searchBooks(String query) async {
    if (query.isEmpty) {
      _googleBooks = [];
      notifyListeners();
      return;
    }

    _loading = true;
    notifyListeners();

    try {
      _googleBooks = await _repository.searchBooks(query);
    } catch (e) {
      _googleBooks = [];
      debugPrint(e.toString());
    }

    _loading = false;
    notifyListeners();
  }

  void onSearch(String value) {
    _searchText = value;

    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(
      const Duration(milliseconds: 500),
      () async {
        if (value.trim().isEmpty) {
          _googleBooks = [];
          notifyListeners();
          return;
        }

        await searchBooks(value.trim());
      },
    );
  }

  //==================================================
  // CATEGORY
  //==================================================

  String _selectedCategory = "All";

  String get selectedCategory => _selectedCategory;

  void changeCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  //==================================================
  // FIREBASE CRUD
  //==================================================

  Future<void> addBook(BookModel book) async {
    _loading = true;
    notifyListeners();

    try {
      await _bookService.addBook(book);
    } catch (e) {
      debugPrint("Add Book Error: $e");
      rethrow;
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> updateBook(BookModel book) async {
    _loading = true;
    notifyListeners();

    try {
      await _bookService.updateBook(book);
    } catch (e) {
      debugPrint("Update Book Error: $e");
      rethrow;
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> deleteBook(String id) async {
    _loading = true;
    notifyListeners();

    try {
      await _bookService.deleteBook(id);
    } catch (e) {
      debugPrint("Delete Book Error: $e");
      rethrow;
    }

    _loading = false;
    notifyListeners();
  }

  //==================================================
  // FIRESTORE STREAMS
  //==================================================

  get allBooks => _bookService.getBooks();

  get featuredBooks => _bookService.getFeaturedBooks();

  get bestSellingBooks => _bookService.getBestSellingBooks();

  get newArrivalBooks => _bookService.getNewArrivalBooks();

  getBooksByCategory(String category) =>
      _bookService.getBooksByCategory(category);

  searchFirestoreBooks(String keyword) =>
      _bookService.searchBooks(keyword);

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}