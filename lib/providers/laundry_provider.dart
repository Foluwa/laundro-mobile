import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/currency.dart';
import '../models/location.dart';
import '../models/product.dart';
import '../widgets/Payments/payment_options.dart';

class LaundryProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _baskets = [];
  List<Category>? _category = [];
  List<Location> _locations = [];
  Currency? _currency;
  PaymentPlatforms? _selectedPayment;

  /// Return gets
  List<Product>? get getProducts => _products;
  List<Product>? get getCart => _baskets;
  List<Category>? get getCategories => _category;
  List<Location>? get getLocations => _locations;
  Currency? get getCurrency => _currency;
  PaymentPlatforms? get getSelectedPayment => _selectedPayment;

  /// Add multiple products to cart to persist cart
  void persistBasket(data) {
    _baskets = data;
    notifyListeners();
  }

  /// Set selected payment
  void setSelectedPayment(data) {
    _selectedPayment = data;
    notifyListeners();
  }

  /// Set Delivery Locations
  void setLocations(data) {
    _locations = data;
    notifyListeners();
  }

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
    _baskets.add(d);
    notifyListeners();
  }

  /// Increament quantity of basket
  void addOneItemToCart(Product p) {
    // check if already in basket
    // if in basket increament by one
    // Product found =
    // _baskets.firstWhere((a) => a.id == p.id, orElse: () => null);
    final found = _baskets.firstWhereOrNull((a) => a.id == p.id);
    print('FOUND IS $found');
    if (found != null) {
      found.qty += 1;
    } else {
      p.qty += 1;
      _baskets.add(p);
    }
    notifyListeners();
  }

  /// Removes one item from  basket(cart)
  void removeOneItemToCart(Product p) {
    // check if already in basket
    // if in basket increment by one
    final found = _baskets.firstWhere((e) => e.id == p.id);
    print('FOUND IS $found');
    if (found.qty == 1) {
      found.qty -= 1;
      _baskets.remove(p);
    } else {
      found.qty -= 1;
    }
    notifyListeners();
  }

  /// Computes quantity of all products in  basket(cart)
  int getBasketQty() {
    var total = 0;
    final bb = _baskets;
    if (bb.isNotEmpty) {
      for (var i = 0; i < bb.length; i++) {
        total += bb[i].qty;
      }
      return total;
    } else {
      return 0;
    }
  }

  /// Computes price of all products in basket(cart)
  double getTotalPrice() {
    var total = 0.0;
    final bb = _baskets;
    // if (bb != null) {
    if (bb.isNotEmpty) {
      for (var i = 0; i < bb.length; i++) {
        total += bb[i].price * bb[i].qty;
      }
      return total;
    } else {
      return total;
    }
  }

  /// Returns boolean if a particular product exists in basket(cart)
  bool inCart(id) {
    final found = _baskets.firstWhereOrNull((e) => e.id == id);
    final ff = found;
    if (ff != null) {
      return true;
    } else {
      return false;
    }
  }

  /// Return quantity of a particular product added to basket(cart)
  int inCartQty(id) {
    final found = _baskets.firstWhereOrNull((e) => e.id == id);
    final ff = found;
    if (ff != null) {
      return ff.qty;
    } else {
      return 0;
    }
  }

  /// Clears basket
  void clearBasket() {
    _baskets.clear();
    notifyListeners();
  }
}
