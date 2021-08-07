import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Constants.white);
    final styleHint = TextStyle(color: Constants.white);
    final style = widget.text.isEmpty ? styleHint : styleActive;
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  })
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
          fillColor: Colors.transparent, //Constants.white,
          filled: true),
      style: style,
      onChanged: widget.onChanged,
    );
  }
}
