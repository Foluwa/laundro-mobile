import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../providers/laundry_provider.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../utils/utils.dart';
import 'Buttons/button_widget.dart';

class BottomCheckout extends StatefulWidget {
  const BottomCheckout({Key? key}) : super(key: key);

  @override
  _BottomCheckoutState createState() => _BottomCheckoutState();
}

class _BottomCheckoutState extends State<BottomCheckout> {
  LaundryProvider _laundryProvider = LaundryProvider();
  bool btnLoading = false;

  final bottomCartStyle = TextStyle(
    color: Constants.white,
    fontSize: SizeConfig.safeBlockHorizontal * 4.5,
    fontWeight: FontWeight.w900,
  );

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
          // Price Value
          Padding(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3.34),
              child: Text(
                  // ignore: lines_longer_than_80_chars
                  '${Utils.getCurrency(_laundryProvider.getCurrency!.currency)} ${_laundryProvider.getTotalPrice()}',
                  style: bottomCartStyle)),

          // Checkout Btn
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3.34),
            child: _laundryProvider.getCart!.length < 1
                ? ButtonWidget(
                    text: 'No item in cart',
                    onClicked: () {},
                    color: Colors.amber,
                    paddingValue: 6.0,
                    btnStatus: btnLoading,
                    style: const TextStyle())
                // TODO: proceed to payment
                : ButtonWidget(
                    text: AppLocalizations.of(context)!.checkout.toString(),
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
