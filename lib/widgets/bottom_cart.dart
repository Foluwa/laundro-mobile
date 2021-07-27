import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/laundry_provider.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';

class BottomCart extends StatefulWidget {
  const BottomCart({Key? key}) : super(key: key);

  @override
  _BottomCartState createState() => _BottomCartState();
}

class _BottomCartState extends State<BottomCart> {
  LaundryProvider _laundryProvider = LaundryProvider();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _laundryProvider = Provider.of<LaundryProvider>(context);

    // 'Items(${_laundryProvider.getBasketQty() ?? 0}) Total: \$${_laundryProvider.getTotalPrice()}'),
    // print('PRICE ${_laundryProvider.getBasketQty()}');
    // print('TOTAL ${_laundryProvider.getTotalPrice()}');
    // SizeConfig().init(context);
    // SizeConfig.safeBlockHorizontal * 7.65;
    print(SizeConfig.safeBlockHorizontal * 3.34);
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/cart'), // /cart
      child: Container(
        height: SizeConfig.safeBlockHorizontal * 20,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Constants.primaryColor,
          // borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3.34), // 12.0
              // ignore: lines_longer_than_80_chars
              child: Text('Your Basket (${_laundryProvider.getBasketQty()})'),
            ),
            Padding(
              padding:
                  EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3.34), // 12.0
              // ignore: lines_longer_than_80_chars
              child: Text(
                  // ignore: lines_longer_than_80_chars
                  'Total: (${_laundryProvider.getCurrency?.currency ?? ''} ${_laundryProvider.getTotalPrice()})'),
              //
            ),
            // Padding(
            //   padding: EdgeInsets.all(12.0),
            //   // child: Text(
            //   //     // ignore: lines_longer_than_80_chars
            //   //     'Total: ${_laundryProvider.getCurrency.currency}${_laundryProvider.getTotalPrice()}'),
            //   //'Total: ${_laundryProvider.getCurrency.currency}${_laundryProvider.getTotalPrice() ?? 0}'),
            // ),
          ],
        ),
      ),
    );
  }
}
