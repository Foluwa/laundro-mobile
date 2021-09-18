import 'package:flutter/material.dart';

import 'size_config.dart';

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

  Color kPrimaryColor = const Color(0xffFC9D45);
  Color kSecondaryColor = const Color(0xff573353);

  static final kTitle = TextStyle(
    fontFamily: 'Klasik',
    fontSize: SizeConfig.blockSizeHorizontal * 7,
    color: primaryColor,
  );

  static final kBodyText1 = TextStyle(
    color: black, //primaryColor,
    fontSize: SizeConfig.blockSizeHorizontal * 4.5,
    fontWeight: FontWeight.bold,
  );
}
