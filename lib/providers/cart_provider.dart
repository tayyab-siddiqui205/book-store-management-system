import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {

  int _totalItems = 0;

  int get totalItems => _totalItems;

  void addItem() {
    _totalItems++;
    notifyListeners();
  }

  void removeItem() {
    if (_totalItems > 0) {
      _totalItems--;
      notifyListeners();
    }
  }

}