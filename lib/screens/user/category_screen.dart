import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundro/models/sub_categories.dart';
import 'package:laundro/providers/laundry_provider.dart';
import 'package:laundro/utils/size_config.dart';
import 'package:provider/provider.dart';

import '../../api/laundry.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatefulWidget {
  SubCategory subCat;
  CategoryScreen({Key key, this.subCat}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String title = 'title';
  LaundryApi api = LaundryApi(addAccessToken: false);
  LaundryProvider _laundryProvider = LaundryProvider();
  bool screenLoading = true;
  List _products;
  @override
  void initState() {
    // getProducts().then((_) => print('fetch currency'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _laundryProvider = Provider.of<LaundryProvider>(context);
    // _laundryProvider
    print('LENGTH ${_laundryProvider.getProducts.length}');
    print('subCat ${widget.subCat.id}');

    // ignore: lines_longer_than_80_chars
    _products = _laundryProvider.getProducts
        .where((e) => e.sub_category_id == widget.subCat.id)
        .toList();
    print('_products $_products');
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.cancel)),
          title: Text(widget.subCat.name),
          pinned: true,
          floating: true,
          flexibleSpace: const Placeholder(),
          expandedHeight: SizeConfig.safeBlockHorizontal * 55.60, //200,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) =>
                ListTile(title: Text('${_products[index].name}')),
            childCount:
                _products.length, // _laundryProvider.getProducts.length, /
          ),
        ),
      ],
    ));
  }
}
