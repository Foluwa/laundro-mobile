import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundro/utils/constants.dart';
import 'package:laundro/widgets/app_header.dart';

import '../../providers/laundry_provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    LaundryProvider _laundryProvider = LaundryProvider();
    print(_laundryProvider.getCart);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppHeader(
            elevation: 0,
            fontSize: 25.0,
            title: 'Checkout',
            bg: const Color(0xFF607D8B),
            textColor: Constants.white,
            onCloseClicked: () => Navigator.pop(context),
            backgroundColor: const Color(0xFF607D8B)),
      ),
      // body: ,
    );
  }
}
