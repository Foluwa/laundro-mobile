import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:maidoki/constants/Constants.dart';

class Loaders {
  static Widget Loader({height, width}) => Container(
        child: SizedBox(
          height: width ?? 125.0,
          width: height ?? 125.0,
          child: const CircularProgressIndicator(),
        ),
        // child: Image.asset(
        //   "assets/logo/logo_maidoki_gif.gif",
        //   height: width ?? 125.0,
        //   width: height ?? 125.0,
        // ),
      );
}
