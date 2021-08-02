import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundro/utils/size_config.dart';
import 'package:laundro/widgets/Buttons/button_widget.dart';
import 'package:provider/provider.dart';

import '../../providers/laundry_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/app_header.dart';
import '../../widgets/single_product.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  LaundryProvider _laundryProvider = LaundryProvider();
  @override
  Widget build(BuildContext context) {
    _laundryProvider = Provider.of<LaundryProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppHeader(
            elevation: 0,
            fontSize: 25.0,
            title: 'Cart',
            bg: const Color(0xFF607D8B),
            textColor: Constants.white,
            onCloseClicked: () => Navigator.pop(context),
            backgroundColor: const Color(0xFF607D8B)),
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
          ? SizedBox()
          : Container(
              height: SizeConfig.safeBlockHorizontal * 20,
              width: double.maxFinite,
              decoration: BoxDecoration(color: Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ButtonWidget(
                    text: 'Proceed', //Place Order
                    onClicked: clickMe,
                    color: Constants.primaryColor,
                    style: TextStyle(fontSize: 30, color: Constants.white),
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
