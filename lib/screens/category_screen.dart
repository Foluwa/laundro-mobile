import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/laundry.dart';
import '../providers/laundry_provider.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../widgets/bottom_cart.dart';
import '../widgets/single_product.dart';

class CategoryScreen extends StatefulWidget {
  final dynamic subCat;
  // ignore: lines_longer_than_80_chars
  const CategoryScreen({Key? key, required this.subCat}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  LaundryApi api = LaundryApi(addAccessToken: true);
  LaundryProvider _laundryProvider = LaundryProvider();
  bool screenLoading = true;
  late List _products;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //Hive.close();
    // Hive.box('cart').close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _laundryProvider = Provider.of<LaundryProvider>(context);
    _products = _laundryProvider.getProducts!
        .where((e) => e.sub_category_id == widget.subCat.id)
        .toList();
    // _products = _laundryProvider.getProducts!;
    print('DESCRIPTION ${widget.subCat.description.toString()}');
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Constants.primaryColor,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.cancel)),
            title: Text(widget.subCat.name),
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: <Widget>[
              Positioned.fill(
                  child: Container(
                foregroundDecoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                        colors: [
                      Color(0xCC000000),
                      Color(0x00000000),
                      Color(0x00000000),
                      Color(0xCC000000),
                    ])),
                child: FadeInImage.assetNetwork(
                  image: widget.subCat.img_url,
                  placeholder: 'assets/spinner.gif', // your assets image path
                  fit: BoxFit.cover,
                ),
              ))
            ])),
            pinned: true,
            floating: true,
            expandedHeight: SizeConfig.safeBlockHorizontal * 55.60,

            ///TODO: Add subcategory description
            //bottom: Container(child: Text(widget.subCat.description)),
          ),
          // Check if _products is null or empty
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => SingleProduct(products: _products[index]),
            childCount: _products.length,
          )),
        ],
      ),
      bottomNavigationBar: const BottomCart(),
    );
  }
}
