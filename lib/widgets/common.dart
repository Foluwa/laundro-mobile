import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Common {
  static Widget Loader({height, width}) => Container(
        child: SizedBox(
          height: width ?? 50.0,
          width: height ?? 50.0,
          child: const CircularProgressIndicator(),
        ),
        // child: Image.asset(
        //   "assets/logo/logo_maidoki_gif.gif",
        //   height: width ?? 125.0,
        //   width: height ?? 125.0,
        // ),
      );
}
