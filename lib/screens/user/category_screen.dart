import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/laundry.dart';
import '../../models/products.dart';
import '../../providers/laundry_provider.dart';
import '../../utils/size_config.dart';
import '../../widgets/bottom_cart.dart';

class CategoryScreen extends StatefulWidget {
  final dynamic subCat;
  // ignore: lines_longer_than_80_chars
  const CategoryScreen({Key? key, required this.subCat}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // String title = 'title';
  LaundryApi api = LaundryApi();
  LaundryProvider _laundryProvider = LaundryProvider();
  bool screenLoading = true;
  late List _products;
  @override
  void initState() {
    // getProducts().then((_) => print('fetch currency'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _laundryProvider = Provider.of<LaundryProvider>(context);
    // print('LENGTH ${_laundryProvider.getProducts.length}');
    // print('subCat ${widget.subCat.id}');
    print('INCART? ${_laundryProvider.inCart(1)}');

    // ignore: lines_longer_than_80_chars
    _products = _laundryProvider.getProducts!
        .where((e) => e.sub_category_id == widget.subCat.id)
        .toList();
    // print('_products $_products');

    // print('CARTITEMS ${_laundryProvider.getCart.length}');
    print('TOTALITEMINCART ${_laundryProvider.getBasketQty()}');
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.cancel)),
            title: Text(widget.subCat.name),
            flexibleSpace: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Image.network(
                  widget.subCat.img_url,
                  fit: BoxFit.cover,
                ))
              ],
            ),
            pinned: true,
            floating: true,
            expandedHeight: 200, // SizeConfig.safeBlockHorizontal * 55.60
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                  title: Text('${_products[index].name}'),
                  subtitle: _laundryProvider.inCart(_products[index].id)
                      ? Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // add item into basket
                                print('add item into basket');
                                print(_products[index]);
                                Product dd = _products[index];
                                _laundryProvider.addOneItemToCart(dd);
                              },
                              icon: const Icon(Icons.add),
                              iconSize: 20,
                            ),
                            Text(
                                // ignore: lines_longer_than_80_chars
                                '${_laundryProvider.inCartQty(_products[index].id)}'),
                            IconButton(
                              onPressed: () {
                                // remove item from basket
                                _laundryProvider
                                    .removeOneItemToCart(_products[index]);
                              },
                              icon: const Icon(Icons.remove),
                              iconSize: 20,
                            )
                          ],
                        )
                      : IconButton(
                          onPressed: () {
                            // add item into basket
                            print('add item into basket');
                            _laundryProvider.addOneItemToCart(_products[index]);
                            _laundryProvider.getBasketQty();
                            _laundryProvider.getTotalPrice();
                            // print(_products[index]);
                            // Product dd = _products[index];
                            // _laundryProvider.addOneItemToCart(dd);
                          },
                          icon: const Icon(Icons.ac_unit_outlined),
                          iconSize: 20,
                        ),
                  trailing: Column(
                    children: [
                      Text(
                          // ignore: lines_longer_than_80_chars
                          '${_laundryProvider.getCurrency!.currency}${_products[index].price}'),
                    ],
                  )),
              childCount:
                  _products.length, // _laundryProvider.getProducts.length, /
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomCart(),
    );
  }
}
