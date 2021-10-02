import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../providers/laundry_provider.dart';
import '../utils/boxes.dart';
import '../utils/constants.dart';
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

                                /// hive db
                                addToCartDB(
                                    widget.products.id, widget.products.qty);
                              },
                              icon: const Icon(Icons.add),
                              iconSize: 15,
                            ),
                            Text(
                              '${_laundryProvider.inCartQty(widget.products.id)}',
                              style: const TextStyle(fontSize: 15.0),
                            ),
                            IconButton(
                              onPressed: () {
                                // remove item from basket
                                _laundryProvider
                                    .removeOneItemToCart(widget.products);

                                /// HIVE DB
                                removeFromCartDB(
                                    widget.products.id, widget.products.qty);
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
                              border:
                                  Border.all(color: Constants.secondaryColor)),
                          child: IconButton(
                              onPressed: () {
                                // add item into basket
                                _laundryProvider
                                    .addOneItemToCart(widget.products);
                                _laundryProvider.getBasketQty();
                                _laundryProvider.getTotalPrice();

                                /// save to hive db
                                addToCartDB(
                                    widget.products.id, widget.products.qty);
                              },
                              icon: const Icon(
                                Icons.add_shopping_cart_rounded,
                                size: 20,
                              )))
                ],
              ))
        ],
      ),
    );
  }

  Future addToCartDB(int productId, int qty) async {
    final order = CartDB()
      ..productId = productId
      ..qty = qty++;

    // check if exists in db
    // if exists increament by 1
    // if not add to db

    // Add into db
    final box = Boxes.getCart();

    if (!box.containsKey(order)) {
      // increament
      // order.qty = order.qty++;
      await box.put(order.productId, order);
      print('ORDER INCREAMENTED SUCCESSFULLY1, ${box.get(order)}');
    } else {
      box.add(order);
      print('ORDER TO DB SUCCESSFULLY1');
    }
  }

  Future removeFromCartDB(int productId, int qty) async {
    final order = CartDB()
      ..productId = productId
      ..qty = qty--;

    final box = Boxes.getCart();
    if (!box.containsKey(order)) {
      // decreament
      await box.put(order.productId, order);
      print('ORDER DECREAMENTED SUCCESSFULLY1, ${box.get(order)}');
    } else {
      // remove
      box.delete(order);
      print('ORDER REMOVED SUCCESSFULLY1, ${box.get(order)}');
    }
  }
}
