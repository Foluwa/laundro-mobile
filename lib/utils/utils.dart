import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class Utils {
  static void showSnackBar(BuildContext context, {required String title}) =>
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(title)));

  static String getCurrency(String locale) {
    var format = NumberFormat.simpleCurrency(
        locale: Platform.localeName, name: locale); //'NGN'
    return format.currencySymbol;
  }
}
