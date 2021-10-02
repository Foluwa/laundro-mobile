import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../providers/laundry_provider.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../widgets/Buttons/button_widget.dart';
import '../widgets/app_header.dart';
import '../widgets/single_product.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  LaundryProvider _laundryProvider = LaundryProvider();
  UserProvider _userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    _laundryProvider = Provider.of<LaundryProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppHeader(
            elevation: 0,
            fontSize: 25.0,
            title: 'Cart',
            bg: Constants.primaryColor,
            textColor: Constants.white,
            onCloseClicked: () => Navigator.pop(context),
            backgroundColor: Constants.primaryColor),
      ),
      body: _laundryProvider.getCart!.length < 1
          ? const Center(
              child: Text('No item in cart'),
            )
          : ListView.builder(
              itemCount: _laundryProvider
                  .getCart?.length, //item.subCategory.subcategory.length,
              itemBuilder: (context, index) => Column(children: [
                SingleProduct(products: _laundryProvider.getCart![index])
              ]),
            ),
      // bottomNavigationBar: PlaceOrder(),
      bottomNavigationBar: _laundryProvider.getCart!.length < 1
          ? const SizedBox()
          : Container(
              height: SizeConfig.safeBlockHorizontal * 20,
              width: double.maxFinite,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _userProvider.getUser == null
                      ? ButtonWidget(
                          btnStatus: false,
                          text: AppLocalizations.of(context)!
                              .create_new_account, //'Create account to continue', //Place Order
                          onClicked: () =>
                              Navigator.of(context).pushNamed('/account'),
                          color: Constants.primaryColor,
                          style:
                              TextStyle(fontSize: 20, color: Constants.white),
                          paddingValue: 10,
                        )
                      : ButtonWidget(
                          btnStatus: false,
                          text: AppLocalizations.of(context)!
                              .proceed, //'Proceed', //Place Order
                          onClicked: () =>
                              Navigator.of(context).pushNamed('/checkout'),
                          color: Constants.primaryColor,
                          style:
                              TextStyle(fontSize: 20, color: Constants.white),
                          paddingValue: 10,
                        ),
                ],
              ),
            ),
    );
  }

  void clickMe() {
    // print('I was clicked');
    Navigator.of(context).pushNamed('/checkout');
  }
}
