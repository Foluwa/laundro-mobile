import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../api/order.dart';
import '../models/order.dart';
import '../providers/order_provider.dart';
import '../utils/constants.dart';
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
    getUserOrders().then((_) => print('fetching orders'));
  }

  @override
  Widget build(BuildContext context) {
    _orderProvider = Provider.of<OrderProvider>(context);
    customerOrders = _orderProvider.getOrders?.orders;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: AppHeader(
                elevation: 0,
                fontSize: 25.0,
                title: 'Order History',
                bg: Constants.primaryColor,
                textColor: Constants.white,
                onCloseClicked: () => Navigator.pop(context),
                backgroundColor: Constants.primaryColor)),
        body: (loadingData)
            ? const Center(child: CircularProgressIndicator())
            : ((customerOrders != null)
                ? ListView.builder(
                    itemCount: _orderProvider.getOrders!.orders.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                              '/single_order',
                              arguments:
                                  _orderProvider.getOrders!.orders[index]),
                          child: ListTile(
                              leading: Image.asset(
                                'assets/images/washlogo.png',
                              ),
                              title: Text(
                                  // ignore: lines_longer_than_80_chars
                                  //'${_orderProvider.getOrders!.orders[index].id}'
                                  '#${_orderProvider.getOrders!.orders[index].orderId}'),
                              subtitle: Text(
                                  // ignore: lines_longer_than_80_chars
                                  //'${_orderProvider.getOrders!.orders[index].deliveryAddress}  '
                                  '${formatTime(_orderProvider.getOrders!.orders[index].createdAt)}'),
                              trailing: const Icon(Icons.arrow_forward_ios)));
                    },
                  )
                : const Center(
                    child: Text('You havent made any orders yet'),
                  )));
  }

  /// Fetch Orders
  Future<OrderList> getUserOrders() async {
    var keys;
    await orderAPI.fetchUserOrders().then((orders) {
      //var data = null;
      _orderProvider.setOrders(orders); //data
      if (mounted) {
        setState(() {
          loadingData = false;
        });
      }
      return orders;
    }).catchError((error) {
      if (mounted) {
        setState(() {
          loadingData = false;
        });
      }
      Common.showSnackBar(context, title: error.toString(), duration: 300);
    });
    return keys;
  }

  String formatTime(time) {
    // final DateTime now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    final dateTime = DateTime.tryParse(time);
    final formatted = formatter.format(dateTime!);
    return formatted;
  }
}
