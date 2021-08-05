import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color color;
  final double paddingValue;
  final TextStyle style;
  final bool btnStatus;

  const ButtonWidget({
    required this.text,
    required this.color,
    required this.style,
    required this.paddingValue,
    required this.onClicked,
    required this.btnStatus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialButton(
        color: color,
        padding: EdgeInsets.all(paddingValue),
        child: btnStatus
            ? const CircularProgressIndicator()
            : Text(
                text,
                style: style,
              ),
        // shape: StadiumBorder(),
        // color: Theme.of(context).accentColor,
        // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // textColor: Colors.white,
        onPressed: onClicked,
      );
}
