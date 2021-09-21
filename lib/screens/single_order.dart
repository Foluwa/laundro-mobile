import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/order_timeline.dart';

class SingleOrder extends StatefulWidget {
  const SingleOrder({Key? key}) : super(key: key);

  @override
  _SingleOrderState createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppHeader(
          elevation: 0,
          fontSize: 25.0,
          title: 'Order #345678',
          bg: const Color(0xFF607D8B),
          textColor: Colors.white,
          onCloseClicked: () => Navigator.pop(context),
          backgroundColor: const Color(0xFF607D8B),
          //backgroundColor: null,
        ),
      ),
      body: const OrderTimeline(),
    );
  }
}
