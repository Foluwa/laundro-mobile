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

  List<Order>? customerOrders;

  late Future myFuture;

  bool loadingData = true;

  @override
  void initState() {
    super.initState();
    getUserOrders().then((_) => print('fetch orders'));
  }

  @override
  Widget build(BuildContext context) {
    _orderProvider = Provider.of<OrderProvider>(context);

    customerOrders = _orderProvider.getOrders?.orders;

    // print('customerOrders $customerOrders');

    // final userO = _orderProvider.getOrders;
    //
    // final lengthOfOrders;
    // lengthOfOrders = userO!.orders;

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
        body: (loadingData)
            ? const Center(child: CircularProgressIndicator())
            : ((customerOrders != null)
                ? ListView.builder(
                    //itemCount: _orderProvider.getOrders!.orders.length,
                    itemCount: _orderProvider.getOrders!.orders.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            '/single_order',
                            arguments: _orderProvider.getOrders!.orders[index]),
                        child: ListTile(
                            title: Text(
                                '#${_orderProvider.getOrders!.orders[index].orderId}'),
                            subtitle: Text(
                                '${_orderProvider.getOrders!.orders[index].deliveryAddress}'),
                            trailing: Icon(Icons.arrow_forward_ios)),
                      );
                    },
                  )
                : const Center(
                    child: Text('No orders yet'),
                  )));
  }

  /// Fetch Orders
  Future<OrderList> getUserOrders() async {
    var keys;
    await orderAPI.fetchUserOrders().then((orders) {
      //var data = null;
      _orderProvider.setOrders(orders); //data
      setState(() {
        loadingData = false;
      });

      return orders;
    }).catchError((error) {
      setState(() {
        loadingData = false;
      });
      Common.showSnackBar(context, title: error.toString(), duration: 300);
    });
    return keys;
  }
}
