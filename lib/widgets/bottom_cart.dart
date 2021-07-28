import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';
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
    // SizeConfig().init(context);
    // SizeConfig.safeBlockHorizontal * 7.65;
    print(SizeConfig.safeBlockHorizontal * 3.34);
    var currentCurrency = _laundryProvider.getCurrency!.currency;
    return currentCurrency == null
        ? CircularProgressIndicator()
        : GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('/cart'), // /cart
            child: Container(
              height: SizeConfig.safeBlockHorizontal * 20,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Constants.primaryColor
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(
                        SizeConfig.safeBlockHorizontal * 3.34), // 12.0
                    // ignore: lines_longer_than_80_chars
                    child: Text(
                        'Your Basket (${_laundryProvider.getBasketQty()})'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        SizeConfig.safeBlockHorizontal * 3.34), // 12.0
                    // ignore: lines_longer_than_80_chars
                    child: Text(
                        // ignore: lines_longer_than_80_chars
                        'Total: (${Utils.getCurrency(_laundryProvider.getCurrency!.currency)} ${_laundryProvider.getTotalPrice()})'),
                    //
                  ),
                ],
              ),
            ),
          );
  }
}
