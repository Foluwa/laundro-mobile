import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:laundro/widgets/Payments/payment_options.dart';

import '../models/categories.dart';
import '../models/currency.dart';
import '../models/location.dart';
import '../models/products.dart';
import '../utils/db/persist_basket.dart';

class LaundryProvider extends ChangeNotifier {
  List<Product> _products = [];
  // List<Product> _baskets = [];
  final List<Product> _baskets = [];
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

  late SqliteDB sqlQuery;

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
    // update quantity of d to 1
    _baskets.add(d);
    notifyListeners();
  }

  /// Increament quantity of basket
  void addOneItemToCart(Product p) {
    // check if already in basket
    // if in basket increament by one
    // Product found =
    //     _baskets.firstWhere((a) => a.id == p.id, orElse: () => null);
    final found = _baskets.firstWhereOrNull((a) => a.id == p.id);
    print('FOUND IS $found');
    if (found != null) {
      found.qty += 1;
      // increament product quantity in sqlite
    } else {
      p.qty += 1;
      _baskets.add(p);
      // add one product into sqlite
    }
    notifyListeners();
  }

  /// remove
  void removeOneItemToCart(Product p) {
    print('IN CART ${p}');
    // check if already in basket
    // if in basket increment by one
    final found = _baskets.firstWhere((e) => e.id == p.id);
    print('FOUND IS $found');
    if (found.qty == 1) {
      found.qty -= 1;
      _baskets.remove(p);
      // add remove product from sqlite
    } else {
      found.qty -= 1;
      // decreament product quantity in sqlite
    }
    notifyListeners();
  }

  /// Computes quantity of all products in cart
  int getBasketQty() {
    var total = 0;
    // print('LENGTH OF BASKET ${_baskets?.length}');
    // var bb = _baskets;
    final bb = _baskets;
    // if (bb != null) {
    if (bb.isNotEmpty) {
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

  /// Extract product id from data in cart
  // List<int> extractProductId() {
  //   // ignore: lines_longer_than_80_chars
  //   var _basketProductId = _baskets.where((i) => i.id).toList();
  //   print('IDS $_basketProductId');
  //   return _basketProductId;
  // }

  /// Clear basket
  void clearBasket() {
    _baskets.clear();
    notifyListeners();
  }
}
