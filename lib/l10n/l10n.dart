import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('ar'),
    const Locale('fr'),
    const Locale('hi'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'ar':
        return '🇦🇪';
      case 'fr':
        return '🇫🇷';
      case 'hi':
        return '🇮🇳';
      case 'en':
      default:
        return '🇺🇸';
    }
  }
}
