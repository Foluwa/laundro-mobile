import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_header.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        // child: AppHeader(
        //   title: 'Order History',
        //   elevation: 0,
        //   fontSize: 25.0,
        //   bg: Colors.blueGrey,
        //   // this.bg,
        //   // this.textColor,
        //   // this.elevation,
        //   // this.bottom,
        //   // this.fontSize,
        //   // this.onCloseClicked,
        // ),
        child: AppHeader(
          elevation: 0,
          fontSize: 25.0,
          title: 'Order History',
          bg: Color(0xFF607D8B),
          textColor: Colors.black,
          onCloseClicked: () => Navigator.pop(context),
          backgroundColor: Color(0xFF607D8B),
          //backgroundColor: null,
        ),
      ),
      body: Center(
        child: Text('Order History'),
      ),
    );
  }
}
