import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundro/widgets/common.dart';
import 'package:provider/provider.dart';

import '../providers/laundry_provider.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../utils/utils.dart';

class BottomCart extends StatefulWidget {
  const BottomCart({Key? key}) : super(key: key);

  @override
  _BottomCartState createState() => _BottomCartState();
}

class _BottomCartState extends State<BottomCart> {
  LaundryProvider _laundryProvider = LaundryProvider();
  late var currentCurrency;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _laundryProvider = Provider.of<LaundryProvider>(context);
    currentCurrency = _laundryProvider.getCurrency?.currency;
    var bottomCartStyle = TextStyle(
      color: Constants.white,
      fontSize: SizeConfig.safeBlockHorizontal * 4.5,
      fontWeight: FontWeight.w900,
    );
    print('currentCurrency $currentCurrency');
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/cart'), // /cart
      child: Container(
        height: SizeConfig.safeBlockHorizontal * 20,
        width: double.maxFinite,
        decoration: BoxDecoration(color: Constants.primaryColor),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3.34),
              child: currentCurrency == null
                  ? Common.simpleShimmer()
                  : Text(
                      'Cart (${_laundryProvider.getBasketQty()})',
                      style: bottomCartStyle,
                    ),
            ),
            Padding(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3.34),
              child: currentCurrency == null
                  ? Common.simpleShimmer()
                  : Text(
                      // ignore: lines_longer_than_80_chars
                      '${Utils.getCurrency(_laundryProvider.getCurrency!.currency)} ${_laundryProvider.getTotalPrice()}',
                      style: bottomCartStyle,
                    ),
              //
            ),
          ],
        ),
      ),
    );
  }
}
