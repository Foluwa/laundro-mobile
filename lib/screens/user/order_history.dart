import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundro/widgets/app_header.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppHeader(
          title: 'Order History',
          elevation: 0,
          fontSize: 25.0,
          bg: Colors.blueGrey,
          // this.bg,
          // this.textColor,
          // this.elevation,
          // this.bottom,
          // this.fontSize,
          // this.onCloseClicked,
        ),
      ),
      body: Center(
        child: Text('Order History'),
      ),
    );
  }
}
