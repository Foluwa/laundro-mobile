import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/order.dart';
import '../models/order.dart';
import '../providers/order_provider.dart';
import '../widgets/app_header.dart';
import '../widgets/common.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

/// lIST ALL ORDERS
/// NEXT PAGE SHOWS TIMELINE, ORDER DETAILS AND REORDER AGAIN

class _OrderHistoryState extends State<OrderHistory> {
  OrderApi orderAPI = OrderApi(addAccessToken: true);
  OrderProvider _orderProvider = OrderProvider();

  late Future myFuture;

  @override
  void initState() {
    super.initState();
    getUserOrders().then((_) => print('fetch orders'));
    //myFuture = getUserOrders();
  }

  @override
  Widget build(BuildContext context) {
    _orderProvider = Provider.of<OrderProvider>(context);

    final userO = _orderProvider.getOrders;

    final lengthOfOrders;
    lengthOfOrders = userO!.orders;

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
                backgroundColor: const Color(0xFF607D8B))),
        // body: _orderProvider.getOrders!.orders.length < 1
        body: ListView.builder(
          itemCount:
              lengthOfOrders.length, //_orderProvider.getOrders!.orders.length,
          itemBuilder: (context, index) {
            // ProjectModel project = projectSnap.data[index];
            // final Order project = _orderProvider.getOrders!.orders[index];
            return GestureDetector(
              // SINGLE_ORDER
              onTap: () => Navigator.of(context).pushNamed('/single_order',
                  arguments: _orderProvider.getOrders!.orders[index]),
              child: ListTile(
                  title: Text(
                      '#${_orderProvider.getOrders!.orders[index].orderId}'),
                  subtitle: Text(
                      '${_orderProvider.getOrders!.orders[index].deliveryAddress}'),
                  trailing: Icon(Icons.arrow_forward_ios)),
            );
          },
        ));
  }

  /// Fetch Orders
  Future<OrderList> getUserOrders() async {
    var keys;
    await orderAPI.fetchUserOrders().then((orders) {
      print('ORDERS ${orders}');

      _orderProvider.setOrders(orders);

      print('JOEBIDEN ${_orderProvider.getOrders!.orders.first}');
      return orders;
    }).catchError((error) {
      print('ERROR CAUGHT ${error}');
      Common.showSnackBar(context, title: error.toString(), duration: 300);
    });
    return keys;
  }
}
