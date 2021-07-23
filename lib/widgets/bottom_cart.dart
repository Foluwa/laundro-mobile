import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class BottomCart extends StatefulWidget {
  const BottomCart({Key key}) : super(key: key);

  @override
  _BottomCartState createState() => _BottomCartState();
}

class _BottomCartState extends State<BottomCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        // borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text('Your Basket'),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text('\$40:00'),
          ),
        ],
      ),
    );
  }
}
