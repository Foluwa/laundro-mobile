import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/constants.dart';

class Common {
  static Widget Loader({height, width}) => SizedBox(
        height: width ?? 50.0,
        width: height ?? 50.0,
        child: const CircularProgressIndicator(),
      );

  static Widget simpleShimmer() => SizedBox(
        width: 100.0,
        height: 50.0,
        child: Shimmer.fromColors(
          baseColor: Constants.silver, //Colors.red,
          highlightColor: Constants.silverhighlight, //Colors.yellow,
          child: const LinearProgressIndicator(),
        ),
      );

  static void showSnackBar(
    BuildContext context, {
    required String title,
    required int duration,
  }) =>
      // Scaffold.of(context)
      //   ..removeCurrentSnackBar()
      //   ..showSnackBar(
      //     SnackBar(content: Text(title)),
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(title),
          duration: Duration(milliseconds: duration),
        ),
      );
}

//['message']['messages']['message']
