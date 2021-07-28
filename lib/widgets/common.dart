import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundro/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

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

  static Widget simpleShimmer() => SizedBox(
        width: 100.0,
        height: 50.0,
        child: Shimmer.fromColors(
          baseColor: Constants.silver, //Colors.red,
          highlightColor: Constants.silverhighlight, //Colors.yellow,
          child: LinearProgressIndicator(),
        ),
      );
}
