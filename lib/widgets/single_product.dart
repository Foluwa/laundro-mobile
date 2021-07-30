import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';
import '../providers/laundry_provider.dart';
import '../utils/utils.dart';

class SingleProduct extends StatefulWidget {
  final Product products;

  const SingleProduct({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  LaundryProvider _laundryProvider = LaundryProvider();
  late var currentCurrency;
  @override
  Widget build(BuildContext context) {
    _laundryProvider = Provider.of<LaundryProvider>(context);
    currentCurrency = _laundryProvider.getCurrency?.currency;
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.products.name),
                Text(
                    // ignore: lines_longer_than_80_chars
                    '${Utils.getCurrency(currentCurrency)}${widget.products.price.toString()}'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(widget.products.description.toString())),
                _laundryProvider.inCart(widget.products.id)
                    ? Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // add item into basket
                              print('add item into basket');
                              final dd = widget.products;
                              _laundryProvider.addOneItemToCart(dd);
                            },
                            icon: const Icon(Icons.add),
                            iconSize: 15,
                          ),
                          Text(
                            // ignore: lines_longer_than_80_chars
                            '${_laundryProvider.inCartQty(widget.products.id)}',
                            style: TextStyle(fontSize: 15.0),
                          ),
                          IconButton(
                            onPressed: () {
                              // remove item from basket
                              _laundryProvider
                                  .removeOneItemToCart(widget.products);
                            },
                            icon: const Icon(Icons.remove),
                            iconSize: 15,
                          )
                        ],
                      )
                    : Container(
                        margin: const EdgeInsets.all(3.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blueAccent)),
                        child: IconButton(
                          onPressed: () {
// add item into basket
                            _laundryProvider.addOneItemToCart(widget.products);
                            _laundryProvider.getBasketQty();
                            _laundryProvider.getTotalPrice();
                          },
                          icon: Icon(
                            Icons.add_shopping_cart_rounded,
                            size: 20,
                          ),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// MaterialButton(
// elevation: 5,
// color: Constants.primaryColor,
// // child: Text('Add to Cart'),
// child: Icon(
// Icons.add_shopping_cart_rounded,
// size: 10,
// ),
// onPressed: () {
// // add item into basket
// _laundryProvider.addOneItemToCart(widget.products);
// _laundryProvider.getBasketQty();
// _laundryProvider.getTotalPrice();
// },
// )
