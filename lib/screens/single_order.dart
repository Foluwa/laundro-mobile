import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/order_timeline.dart';

class SingleOrder extends StatefulWidget {
  final dynamic order;
  const SingleOrder({Key? key, required this.order}) : super(key: key);

  @override
  _SingleOrderState createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
  @override
  Widget build(BuildContext context) {
    print('SINGLE_ORDER ${widget.order}');
    //Order customerOrder = widget.order;
    final customerOrder = widget.order;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppHeader(
              elevation: 0,
              fontSize: 25.0,
              title: '#${customerOrder.orderId}',
              bg: const Color(0xFF607D8B),
              textColor: Colors.white,
              onCloseClicked: () => Navigator.pop(context),
              backgroundColor: const Color(0xFF607D8B))),
      body: const OrderTimeline(),
      //body: Center(child: Text('#${customerOrder.orderId}')),
    );
  }
}
