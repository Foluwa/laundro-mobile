import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownButton extends StatefulWidget {
  const DropdownButton({Key? key}) : super(key: key);

  @override
  _DropdownButtonState createState() => _DropdownButtonState();
}

class _DropdownButtonState extends State<DropdownButton> {
  @override
  Widget build(BuildContext context) {
    List listUserType = [
      {'name': 'Individual', 'value': 'individual'},
      {'name': 'Company', 'value': 'company'}
    ];
    return DropdownButtonFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.settings),
          hintText: 'Organisation Type',
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(color: Colors.yellow),
        ),
        items: listUserType.map((map) {
          return DropdownMenuItem(
            child: Text(map['name']),
            value: map['value'],
          );
        }).toList());
  }
}
