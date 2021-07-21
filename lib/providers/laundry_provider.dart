import 'package:flutter/material.dart';

import '../models/categories.dart';
import '../models/currency.dart';
import '../models/products.dart';

class LaundryProvider extends ChangeNotifier {
  List<Category> _category;
  List<Product> _products;
  Currency _currency;

  /// Set Products Categories
  void setProducts(data) {
    print('SETTING Products $data');
    _products = data;
    notifyListeners();
  }

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
  List<Product> get getProducts => _products;
  List<Category> get getCategories => _category;
  Currency get getCurrency => _currency;
}
