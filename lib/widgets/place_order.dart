import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({Key? key}) : super(key: key);

  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print('Place order');
        }, // /cart
        child: const Text('kkkk'));
  }
}
