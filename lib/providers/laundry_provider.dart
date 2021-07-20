import 'package:flutter/material.dart';

import '../models/categories.dart';
import '../models/currency.dart';

class LaundryProvider extends ChangeNotifier {
  List<Category> _category;
  Currency _currency;

  /// Set Products Categories
  void setCategories(data) {
    print('SETTING CATEGORIES $data');
    _category = data;
    notifyListeners();
  }

  /// Set Currency
  void setCurrency(data) {
    print('SETTING CURRENCY $data');
    _currency = data;
    notifyListeners();
  }

  /// Return gets
  List<Category> get getCategories => _category;
  Currency get getCurrency => _currency;
}
