import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

// Todo sprcify keyboard input type
// keyboardType: TextInputType.number,
class FormInput extends StatefulWidget {
  bool passwordVisible = false;
  bool obscureText;
  String label;
  final String? Function(String?)? textValidator;
  TextEditingController controller;

  FormInput({
    Key? key,
    required this.passwordVisible,
    required this.label,
    required this.controller,
    required this.obscureText,
    required this.textValidator,
  }) : super(key: key);

  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  var labelStyle = const TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
      color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        autofocus: false,
        validator: widget.textValidator,
        obscureText: widget.obscureText
            ? (widget.obscureText
                ? widget.passwordVisible
                : !widget.passwordVisible)
            : false,
        controller: widget.controller,
        decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: labelStyle,
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
      ),
    );
  }
}
