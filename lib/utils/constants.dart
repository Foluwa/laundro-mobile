import 'package:flutter/material.dart';

class Constants {
  /// APP SETTINGS
  static String appName = 'Laundro';
  static bool showDebugBanner = false;

  /// COLORS
  static Color primaryColor = const Color(0xFF607D8B);
  static Color secondaryColor = const Color(0xFF2A2D3E);
  static Color bgColor = const Color(0xFF212332);
  static Color black = const Color(0xFF000000);
  static Color white = const Color(0xFFFFFFFF);
  static Color silver = const Color(0xFFE0E0E0);
  static Color silverhighlight = const Color(0xFFF5F5F5);

  /// SPACING
  var defaultPadding = 16.0;

  /// APIS
  static String baseUrl =
      'https://laundro-staging-api.herokuapp.com'; // without slash

  static const String POPPINS = 'Poppins';
  static const String OPEN_SANS = 'OpenSans';
  static const String SKIP = 'Skip';
  static const String NEXT = 'Next';
  static const String SLIDER_HEADING_1 = 'Easy Exchange!';
  static const String SLIDER_HEADING_2 = 'Easy to Use!';
  static const String SLIDER_HEADING_3 = 'Connect with Others';
  // ignore: lines_longer_than_80_chars
  static const String SLIDER_DESC =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ultricies, erat vitae porta consequat.';
}
