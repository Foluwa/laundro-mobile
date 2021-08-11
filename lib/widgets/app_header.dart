import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  String title = 'Header';
  Color bg = Colors.white;
  Color textColor = Colors.black;
  double elevation = 0.0;
  double fontSize = 30.0;
  Function onCloseClicked;
  AppHeader(
      {Key? key,
      required this.title,
      required this.bg,
      required this.textColor,
      required this.elevation,
      required this.fontSize,
      required this.onCloseClicked,
      required Color backgroundColor,
      IconButton? leading})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bg, //?? Colors.white,
      elevation: elevation, // ?? 0,
      title: Text(
        title,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
      leading: IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () =>
            // ignore: unnecessary_null_comparison
            onCloseClicked != null ? onCloseClicked() : Navigator.pop(context),
      ),
      actions: [],
    );
  }
}
