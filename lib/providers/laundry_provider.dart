import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../models/categories.dart';
import '../models/currency.dart';
import '../models/products.dart';

class LaundryProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _baskets = [];
  List<Category>? _category = [];
  Currency? _currency;

  /// Return gets
  List<Product>? get getProducts => _products;
  List<Product>? get getCart => _baskets;
  List<Category>? get getCategories => _category;
  Currency? get getCurrency => _currency;

  /// Set Products Categories
  void setProducts(data) {
    _products = data;
    notifyListeners();
  }

  /// Set Products Categories
  void setCategories(data) {
    _category = data;
    notifyListeners();
  }

  /// Set Currency
  void setCurrency(data) {
    _currency = data;
    notifyListeners();
  }

  void addToCart(d) {
    print(d);
    d.qty += 1;
    // update quantity of d to 1
    _baskets.add(d);
    notifyListeners();
  }

  /// Increament quantity of basket
  void addOneItemToCart(Product p) {
    print(p);
    // check if already in basket
    // if in basket increament by one
    print('Product_ID ${p.id}');
    // Product found =
    //     _baskets.firstWhere((a) => a.id == p.id, orElse: () => null);
    final found = _baskets.firstWhereOrNull((a) => a.id == p.id);
    print('FOUND IS $found');
    if (found != null) {
      found.qty += 1;
    } else {
      _baskets.add(p);
    }
    notifyListeners();
  }

  /// remove
  void removeOneItemToCart(Product p) {
    print('IN CART ${p.id}');
    // check if already in basket
    // if in basket increment by one
    final found = _baskets.firstWhere((e) => e.id == p.id);
    print('FOUNDYY $found');
    print('FOUND IS $found');
    if (found.qty == 1) {
      _baskets.remove(p);
    } else {
      found.qty -= 1;
    }
    notifyListeners();
  }

  /// Computes quantity of all products in cart
  int getBasketQty() {
    print('CALLING cart quantity');
    var total = 0;
    // print('LENGTH OF BASKET ${_baskets?.length}');
    var bb = _baskets;
    if (bb != null) {
      for (var i = 0; i < bb.length; i++) {
        total += bb[i].qty;
      }
      return total;
    } else {
      return 0;
    }
  }

  /// Computes price of all products in cart
  double getTotalPrice() {
    var total = 0.0;
    var bb = _baskets;
    if (bb != null) {
      for (var i = 0; i < bb.length; i++) {
        total += bb[i].price * bb[i].qty;
      }
      return total;
    } else {
      return total;
    }
  }

  /// Rturns boolean if a particular product exists in cart
  bool inCart(id) {
    print('IN CART ${id}');
    final found = _baskets.firstWhereOrNull((e) => e.id == id);
    print('FOUNDYY $found');
    final ff = found;
    if (ff != null) {
      return true;
    } else {
      return false;
    }
  }

  /// Return quntity of a particular product added to cart
  int inCartQty(id) {
    print('IN CART ${id}');
    final found = _baskets.firstWhereOrNull((e) => e.id == id);
    print('FOUNDYY $found');
    final ff = found;
    if (ff != null) {
      return ff.qty;
    } else {
      return 0;
    }
  }

  /// Clear basket
  void clearBasket() {
    _baskets.clear();
    notifyListeners();
  }
}
