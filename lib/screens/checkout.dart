import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/size_config.dart';
import '../widgets/app_header.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print(SizeConfig.safeBlockHorizontal * 3.34);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(50), // SizeConfig.safeBlockHorizontal * 3.34
        child: AppHeader(
          elevation: 0,
          fontSize: 25.0,
          title: 'Checkout',
          bg: const Color(0xFF607D8B),
          textColor: Colors.black,
          onCloseClicked: () => Navigator.pop(context),
          backgroundColor: const Color(0xFF607D8B),
          //backgroundColor: null,
        ),
      ),
      body: Column(
        children: [
          const Center(
            child: Text('Checkout'),
          )
        ],
      ),
    );
  }
}
