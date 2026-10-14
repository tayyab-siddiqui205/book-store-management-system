import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {

  final List<String> _wishlist = [];

  List<String> get wishlist => _wishlist;

  void toggle(String bookId) {

    if (_wishlist.contains(bookId)) {
      _wishlist.remove(bookId);
    } else {
      _wishlist.add(bookId);
    }

    notifyListeners();
  }

}