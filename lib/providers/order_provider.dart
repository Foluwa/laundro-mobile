import 'package:flutter/material.dart';

import '../models/order.dart';

class OrderProvider with ChangeNotifier {
  OrderList? _orders;

  bool _isDropIn = false;

  DateTime? _pickedDate;
  TimeOfDay? _time;

  void setUserSelectedDate(date) {
    _pickedDate = date;
    notifyListeners();
  }

  void setUserSelectedTime(time) {
    _time = time;
    notifyListeners();
  }

  /// set is drop in
  void setIsDropIn(state) {
    print('STATE $state');
    _isDropIn = state;
    notifyListeners();
  }

  /// Set user orders
  void setOrders(orders) {
    _orders = orders;
    notifyListeners();
  }

  OrderList? get getOrders => _orders;
  bool get isDropIn => _isDropIn;

  DateTime? get getUserSelectedDate => _pickedDate;
  TimeOfDay? get getUserSelectedTime => _time;
}
