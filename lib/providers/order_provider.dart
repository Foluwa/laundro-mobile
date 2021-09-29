import 'package:flutter/material.dart';

import '../models/order.dart';

class OrderProvider with ChangeNotifier {
  OrderList? _orders;

  /// Set user orders
  void setOrders(orders) {
    _orders = orders;
    notifyListeners();
  }

  OrderList? get getOrders => _orders;
}
