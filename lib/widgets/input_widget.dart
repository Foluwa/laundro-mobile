import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

// Widget formInput({label, controller, obscureText = false, passwordVisible}) {
class FormInput extends StatefulWidget {
  bool passwordVisible = false;
  bool obscureText = false;
  String label;
  TextEditingController controller;
  // ignore: lines_longer_than_80_chars
  FormInput({
    Key? key,
    required this.passwordVisible,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // validator: label == 'Email Address'
      //     ? FormValidate.validateEmail
      //     : FormValidate.validatePassword,
      obscureText: widget.obscureText
          ? (widget.obscureText
              ? widget.passwordVisible
              : !widget.passwordVisible)
          : false,
      controller: widget.controller,
      decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.grey),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    widget.passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Constants.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.passwordVisible = !widget.passwordVisible;
                    });
                  },
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          // enabledBorder: OutlineInputBorder(
          //     borderSide: BorderSide(color: Colors.grey[400])),
          // border: OutlineInputBorder(
          //     borderSide: BorderSide(color: Colors.grey[400])),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green))),
    );
  }
}
