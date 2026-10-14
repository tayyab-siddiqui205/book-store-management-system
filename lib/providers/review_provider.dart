import 'package:flutter/material.dart';

class ReviewProvider extends ChangeNotifier {

  double _rating = 0;

  double get rating => _rating;

  void updateRating(double value) {
    _rating = value;
    notifyListeners();
  }

}