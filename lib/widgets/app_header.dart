import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final Color bg;
  final Color textColor;
  final double elevation;
  final Widget bottom;
  final double fontSize;
  final Function onCloseClicked;
  const AppHeader(
      {Key key,
      this.title,
      this.bg,
      this.textColor,
      this.elevation,
      this.bottom,
      this.fontSize,
      this.onCloseClicked,
      Color backgroundColor,
      IconButton leading})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bg ?? Colors.white,
      elevation: elevation ?? 0,
      title: Text(title ?? 'Header'),
      leading: IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () =>
            onCloseClicked != null ? onCloseClicked() : Navigator.pop(context),
      ),
      actions: [],
    );
  }
}
