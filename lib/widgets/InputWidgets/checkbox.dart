import 'package:flutter/material.dart';

class CheckboxOption extends StatefulWidget {
  final String title;
  bool checkedValue = false;
  final bool newValue;
  final Function(bool?)? onPressed;
  CheckboxOption({
    Key? key,
    required this.checkedValue,
    required this.newValue,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  _CheckboxOptionState createState() => _CheckboxOptionState();
}

class _CheckboxOptionState extends State<CheckboxOption> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      value: widget.checkedValue,
      //onChanged: widget.onPressed,
      onChanged: (newValue) {
        setState(() {
          widget.checkedValue = newValue!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }
}
