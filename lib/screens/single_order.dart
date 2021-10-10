import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../utils/constants.dart';
import '../widgets/app_header.dart';

class SingleOrder extends StatefulWidget {
  final dynamic order;
  const SingleOrder({Key? key, required this.order}) : super(key: key);

  @override
  _SingleOrderState createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
  @override
  Widget build(BuildContext context) {
    final customerOrder = widget.order;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppHeader(
              elevation: 0,
              fontSize: 25.0,
              title: '#${customerOrder.orderId}',
              bg: Constants.primaryColor,
              textColor: Constants.white,
              onCloseClicked: () => Navigator.pop(context),
              backgroundColor: Constants.primaryColor)),
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 0.0,
              top: 10.0,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/images/washing_machine_illustration.png',
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: kToolbarHeight),
                    // GestureDetector(
                    //     onTap: () => Navigator.pop(context),
                    //     child: const Icon(Icons.cancel, color: Colors.red)),
                    // SizedBox(height: 20.0),
                    SizedBox(height: 5.0),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Constants.white),
                      padding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Details',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Color.fromRGBO(74, 77, 84, 1),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            'WASHING AND FOLDING',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(143, 148, 162, 1),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          getItemRow('3', 'T-shirts (man)', '\$30.00'),
                          getItemRow('2', 'T-shirts (man)', '\$40.00'),
                          getItemRow('4', 'Pants (man)', '\$80.00'),
                          getItemRow('1', 'Jeans (man)', '\$20.00'),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            'IRONING',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(143, 148, 162, 1),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          getItemRow('3', 'T-shirt (woman)', '\$30.00'),
                          Divider(),
                          getSubtotalRow('Subtotal', '\$200.00'),
                          getSubtotalRow('Delivery', '\$225.00'),
                          SizedBox(
                            height: 10.0,
                          ),
                          getTotalRow('Total', '\$225.00'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(16.0),
                      //height: ScreenUtil().setHeight(127.0),
                      height: 127.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Your clothes are now washing.',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Color.fromRGBO(74, 77, 84, 1),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Estimated Delivery\n',
                                      style: TextStyle(
                                        color: Color.fromRGBO(143, 148, 162, 1),
                                      ),
                                    ),
                                    TextSpan(
                                      text: '24 January 2021',
                                      style: TextStyle(
                                        color: Color.fromRGBO(74, 77, 84, 1),
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                'assets/images/washlogo.png',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(16.0),
                      //height: ScreenUtil().setHeight(127.0),
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          TimelineTile(
                              alignment: TimelineAlign.manual,
                              lineXY: 0.1,
                              isFirst: true,
                              indicatorStyle: const IndicatorStyle(
                                  width: 20,
                                  color: Color(0xFF27AA69),
                                  padding: EdgeInsets.all(6)),
                              endChild: _RightChild(
                                  asset:
                                      'assets/images/delivery/order_placed.png',
                                  title:
                                      // ignore: lines_longer_than_80_chars
                                      'Order Placed ${toBeginningOfSentenceCase(customerOrder.status)}',
                                  message: 'Order received.'),
                              beforeLineStyle:
                                  const LineStyle(color: Color(0xFF27AA69))),
                          TimelineTile(
                              alignment: TimelineAlign.manual,
                              lineXY: 0.1,
                              indicatorStyle: const IndicatorStyle(
                                width: 20,
                                color: Color(0xFF27AA69),
                                padding: EdgeInsets.all(6),
                              ),
                              endChild: const _RightChild(
                                  asset:
                                      'assets/images/delivery/order_confirmed.png',
                                  title: 'Order Confirmed',
                                  message: 'Order confirmed.'),
                              beforeLineStyle:
                                  const LineStyle(color: Color(0xFF27AA69))),
                          TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.1,
                            indicatorStyle: const IndicatorStyle(
                                width: 20,
                                color: Color(0xFF2B619C),
                                padding: EdgeInsets.all(6)),
                            endChild: const _RightChild(
                                asset:
                                    'assets/images/delivery/order_processed.png',
                                title: 'Order Processed',
                                message: 'Order Processed'),
                            beforeLineStyle:
                                const LineStyle(color: Color(0xFF27AA69)),
                            afterLineStyle: const LineStyle(
                              color: Color(0xFFDADADA),
                            ),
                          ),
                          TimelineTile(
                              alignment: TimelineAlign.manual,
                              lineXY: 0.1,
                              isLast: true,
                              indicatorStyle: const IndicatorStyle(
                                  width: 20,
                                  color: Color(0xFFDADADA),
                                  padding: EdgeInsets.all(6)),
                              endChild: const _RightChild(
                                  disabled: true,
                                  asset:
                                      'assets/images/delivery/ready_to_pickup.png',
                                  title: 'Ready to Pickup',
                                  message: 'Ready to Pickup'),
                              beforeLineStyle:
                                  const LineStyle(color: Color(0xFFDADADA)))
                        ],
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    MaterialButton(
                      onPressed: () => {},
                      child: const Text('REORDER'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Text(customerOrder.orderFirstName.toString()),
      // Text(customerOrder.orderLastName.toString()),
      // Text(customerOrder.orderPhoneNumber.toString()),
      // Text(customerOrder.orderNotes.toString()),
      // Text(customerOrder.orderAddress.toString()),
      // Text(customerOrder.paymentMethod.toString()),
      // Text(customerOrder.totalPrice.toString()),
      // Text(customerOrder.deliveryPrice.toString()),
      // Text(customerOrder.deliveryPickupTime.toString()),
      //Text('')
      // MaterialButton(
      //   onPressed: () => {},
      //   child: const Text('REORDER'),
      // )
      //],
    );
  }
}

class _RightChild extends StatelessWidget {
  const _RightChild({
    Key? key,
    required this.asset,
    required this.title,
    required this.message,
    this.disabled = false,
  }) : super(key: key);
  final String asset;
  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: <Widget>[
          Opacity(
              child: Image.asset(asset, height: 50),
              opacity: disabled ? 0.5 : 1),
          const SizedBox(width: 16),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(title,
                    style: GoogleFonts.yantramanav(
                        color: disabled
                            ? const Color(0xFFBABABA)
                            : const Color(0xFF636564),
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 6),
                Text(message,
                    style: GoogleFonts.yantramanav(
                        color: disabled
                            ? const Color(0xFFD5D5D5)
                            : const Color(0xFF636564),
                        fontSize: 16)),
              ]),
        ]));
  }
}

Widget getTotalRow(String title, String amount) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color.fromRGBO(19, 22, 33, 1),
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        Text(
          amount,
          style: TextStyle(
            color: Constants.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 17.0,
          ),
        )
      ],
    ),
  );
}

Widget getSubtotalRow(String title, String price) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        Text(
          price,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
          ),
        )
      ],
    ),
  );
}

Widget getItemRow(String count, String item, String price) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          count,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            ' x $item',
            style: TextStyle(
              color: Color.fromRGBO(143, 148, 162, 1),
              fontSize: 15.0,
            ),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
          ),
        )
      ],
    ),
  );
}
