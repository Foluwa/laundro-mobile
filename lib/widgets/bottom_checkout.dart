import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/laundry_provider.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import 'Buttons/button_widget.dart';

class BottomCheckout extends StatefulWidget {
  const BottomCheckout({Key? key}) : super(key: key);

  @override
  _BottomCheckoutState createState() => _BottomCheckoutState();
}

class _BottomCheckoutState extends State<BottomCheckout> {
  LaundryProvider _laundryProvider = LaundryProvider();
  bool btnLoading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _laundryProvider = Provider.of<LaundryProvider>(context);
    return Container(
      height: SizeConfig.safeBlockHorizontal * 20,
      width: double.maxFinite,
      decoration: BoxDecoration(color: Constants.primaryColor),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3.34),
              child: const Text('TOTAL')),
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3.34),
            // proceed to payment
            child: ButtonWidget(
                text: 'Checkout',
                onClicked: () => btnLoading ? null : checkoutCart(),
                color: Colors.amber,
                paddingValue: 6.0,
                btnStatus: btnLoading,
                style: const TextStyle()),
          ),
        ],
      ),
    );
  }

  void checkoutCart() {
    print('Checking out cart');
  }
}
