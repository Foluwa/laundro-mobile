import 'package:flutter/material.dart';

class CheckboxOption extends StatefulWidget {
  final String title;
  final bool checkedValue;
  final bool newValue;
  final VoidCallback? onPressed;
  const CheckboxOption({
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
      onChanged: (wi) {},
      // onChanged: (newValue) {
      //   setState(() {
      //     widget.checkedValue = widget.newValue;
      //   });
      // },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }
}
