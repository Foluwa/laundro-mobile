import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static void showSnackBar(BuildContext context, {required String title}) =>
      // Scaffold.of(context)
      //   ..removeCurrentSnackBar()
      //   ..showSnackBar(
      //     SnackBar(content: Text(title)),
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(title),
          duration: const Duration(milliseconds: 300),
        ),
      );

  static String getCurrency(String locale) {
    var format = NumberFormat.simpleCurrency(
        locale: Platform.localeName, name: locale); //'NGN'
    return format.currencySymbol;
  }
}
