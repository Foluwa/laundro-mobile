import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundro/widgets/app_header.dart';
import 'package:provider/provider.dart';

import '../../providers/laundry_provider.dart';

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
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Constants.primaryColor,
      //   title: Text(Constants.appName),
      //   actions: [
      //     IconButton(
      //         onPressed: () => Navigator.of(context).pushNamed('/search'),
      //         icon: const Icon(Icons.search)),
      //     IconButton(
      //         onPressed: () =>
      //             Navigator.of(context).pushNamed('/order_history'),
      //         icon: const Icon(Icons.history)),
      //     IconButton(
      //         onPressed: () => Navigator.of(context).pushNamed('/account'),
      //         icon: const Icon(Icons.person)),
      //   ],
      // ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppHeader(
          elevation: 0,
          fontSize: 25.0,
          title: 'Cart',
          bg: Color(0xFF607D8B),
          textColor: Colors.black,
          onCloseClicked: () => Navigator.pop(context),
          backgroundColor: Color(0xFF607D8B),
          //backgroundColor: null,
        ),
      ),
      body: ListView.builder(
        itemCount: _laundryProvider
            .getCart?.length, //item.subCategory.subcategory.length,
        itemBuilder: (context, index) => Column(
          children: [
            ListTile(
              title: _laundryProvider.getCart!.isEmpty
                  //TODO: Check if empty and display no product
                  ? GestureDetector(
                      onTap: () => null,
                      child: const Center(child: Text('Empty')))
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: Row(
                        children: [
                          Text(_laundryProvider.getCart![index].name),
                          // ignore: lines_longer_than_80_chars
                          Text(
                              // ignore: lines_longer_than_80_chars
                              '  QTY: ${_laundryProvider.getCart![index].qty.toString()}'),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
