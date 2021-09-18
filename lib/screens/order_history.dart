import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_header.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

/// lIST ALL ORDERS
/// NEXT PAGE SHOWS TIMELINE, ORDER DETAILS AND REORDER AGAIN

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppHeader(
            elevation: 0,
            fontSize: 25.0,
            title: 'Order History',
            bg: const Color(0xFF607D8B),
            textColor: Colors.white,
            onCloseClicked: () => Navigator.pop(context),
            backgroundColor: const Color(0xFF607D8B),
            //backgroundColor: null,
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('/single_order'),
              child: const ListTile(
                  title: Text('Battery Full'),
                  subtitle: Text('The battery is full.'),
                  leading: CircleAvatar(backgroundImage: AssetImage('')),
                  trailing: Icon(Icons.arrow_forward_ios)),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('/single_order'),
              child: const ListTile(
                  title: Text('Anchor'),
                  subtitle: Text('Lower the anchor.'),
                  leading: CircleAvatar(backgroundImage: AssetImage('')),
                  trailing: Icon(Icons.arrow_forward_ios)),
            ),
            const ListTile(
                title: Text('Alarm'),
                subtitle: Text('This is the time.'),
                leading: CircleAvatar(backgroundImage: AssetImage('')),
                trailing: Icon(Icons.arrow_forward_ios)),
            const ListTile(
                title: Text('Ballot'),
                subtitle: Text('Cast your vote.'),
                leading: CircleAvatar(backgroundImage: AssetImage('')),
                trailing: Icon(Icons.arrow_forward_ios))
          ],
        ));
  }
}
