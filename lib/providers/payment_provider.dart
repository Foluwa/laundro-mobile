import 'package:flutter/material.dart';

import '../models/payment/flutterwave.dart';

class PaymentProvider with ChangeNotifier {
  FlutterwaveModel? _flutterwaveKeys;

  /// Set current user
  void setFlutterwaveKeys(keys) {
    _flutterwaveKeys = keys;
    notifyListeners();
  }

  FlutterwaveModel? get getFlutterwaveKeys => _flutterwaveKeys;
}
