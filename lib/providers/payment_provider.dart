import 'package:flutter/material.dart';

import '../models/payment/flutterwave.dart';

class PaymentProvider with ChangeNotifier {
  Flutterwave? _flutterwaveKeys;

  /// Set current user
  void setFlutterwaveKeys(keys) {
    _flutterwaveKeys = keys;
    notifyListeners();
  }

  Flutterwave? get getFlutterwaveKeys => _flutterwaveKeys;
}
