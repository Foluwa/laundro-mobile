import 'package:flutter/material.dart';

import 'size_config.dart';

class Constants {
  /// APP SETTINGS
  static String businessName = 'Raftware LTD';
  static String appName = 'Laundro';
  static bool showDebugBanner = false;

  /// APIS
  static String baseUrl =
      'https://laundro-staging-api.herokuapp.com'; // without slash

  /// COLORS
  static Color primaryColor = const Color(0xFF607D8B);
  static Color secondaryColor = const Color(0xFF2A2D3E);

  static Color black = const Color(0xFF000000);
  static Color white = const Color(0xFFFFFFFF);
  static Color silver = const Color(0xFFE0E0E0);
  static Color silverhighlight = const Color(0xFFF5F5F5);
  static Color blueHighlight = const Color(0xFF448AFF);

  static Color lightGrey = const Color(0xFFE0E0E0);
  static Color thickGrey = const Color(0xFF757575);
  static Color yellow = const Color(0xFFFFC107);

  /// Style
  static final kTitle = TextStyle(
    fontSize: SizeConfig.blockSizeHorizontal * 7,
    color: primaryColor,
  );

  static final kBodyText1 = TextStyle(
    color: white,
    fontSize: SizeConfig.blockSizeHorizontal * 4.5,
    fontWeight: FontWeight.bold,
  );
}
