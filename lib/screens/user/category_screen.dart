import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundro/utils/utils.dart';
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
  LaundryApi api = LaundryApi();
  LaundryProvider _laundryProvider = LaundryProvider();
  bool screenLoading = true;
  late List _products;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _laundryProvider = Provider.of<LaundryProvider>(context);
    // ignore: lines_longer_than_80_chars
    _products = _laundryProvider.getProducts!
        .where((e) => e.sub_category_id == widget.subCat.id)
        .toList();
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
            expandedHeight: SizeConfig.safeBlockHorizontal *
                55.60, //200, // SizeConfig.safeBlockHorizontal * 55.60
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
                title: Text('${_products[index].name}'),
                subtitle: Text('${_products[index].description}'),
                trailing: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                          // ignore: lines_longer_than_80_chars
                          '${Utils.getCurrency(_laundryProvider.getCurrency!.currency)}${_products[index].price}'),
                      _laundryProvider.inCart(_products[index].id)
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
                                _laundryProvider
                                    .addOneItemToCart(_products[index]);
                                _laundryProvider.getBasketQty();
                                _laundryProvider.getTotalPrice();
                              },
                              icon: const Icon(Icons.add_shopping_cart),
                              iconSize: 20,
                            ),
                    ],
                  ),
                )),
            childCount: _products.length,
          )),
        ],
      ),
      bottomNavigationBar: const BottomCart(),
    );
  }
}
