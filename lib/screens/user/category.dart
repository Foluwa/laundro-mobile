import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/laundry.dart';
import '../../models/categories.dart';
import '../../models/currency.dart';
import '../../providers/laundry_provider.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../../widgets/common.dart';

class CategoryWidgetList extends StatefulWidget {
  const CategoryWidgetList({Key key}) : super(key: key);

  @override
  _CategoryWidgetListState createState() => _CategoryWidgetListState();
}

class _CategoryWidgetListState extends State<CategoryWidgetList> {
  LaundryApi api = LaundryApi(addAccessToken: false);
  LaundryProvider _laundryProvider = LaundryProvider();

  bool screenLoading = true;

  @override
  void initState() {
    getCurrencies().then((_) => print('fetch currency'));
    getCategories().then((_) => print('fetch categories'));
    getAllProducts().then((_) => print('fetch products'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _laundryProvider = Provider.of<LaundryProvider>(context);

    // print(
    //     'CURRENT CURRENCY ${_laundryProvider.getCurrency.currency}');

    if (_laundryProvider.getCategories == null) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Constants.primaryColor,
          title: Text(Constants.appName),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).pushNamed('/search'),
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/order_history'),
                icon: const Icon(Icons.history)),
            IconButton(
                onPressed: () => Navigator.of(context).pushNamed('/account'),
                icon: const Icon(Icons.person)),
          ],
        ),
        body: Center(
          child: Common.Loader(
              height: SizeConfig.safeBlockHorizontal * 8.5,
              width: SizeConfig.safeBlockHorizontal * 8.5),
        ),
      );
    }
    return DefaultTabController(
      length: _laundryProvider.getCategories.length,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Constants.primaryColor,
            title: Text(Constants.appName),
            actions: [
              IconButton(
                  onPressed: () => Navigator.of(context).pushNamed('/search'),
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/order_history'),
                  icon: const Icon(Icons.history)),
              IconButton(
                  onPressed: () => Navigator.of(context).pushNamed('/account'),
                  icon: const Icon(Icons.person)),
            ],
            bottom: TabBar(
              isScrollable: true,
              indicatorWeight: SizeConfig.safeBlockHorizontal * 2.55, //10.0,
              indicatorColor: Colors.black,
              tabs: _laundryProvider.getCategories.map((title) {
                return Tab(
                  icon: const Icon(Icons.local_laundry_service_outlined),
                  text: title.Name,
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: _laundryProvider.getCategories.map((item) {
              return ListView.builder(
                itemCount: item.subCategory.subcategory.length,
                itemBuilder: (context, index) => ListTile(
                  title: item.subCategory.subcategory.isEmpty

                      //TODO: Check if empty and display no product
                      ? GestureDetector(
                          onTap: () => null,
                          // ignore: lines_longer_than_80_chars
                          child: const Center(child: Text('Empty')))
                      : GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                              '/category_details',
                              arguments: item.subCategory.subcategory[index]),
                          // ignore: lines_longer_than_80_chars
                          child: Text(
                              '${item.subCategory.subcategory[index].name}'),
                        ),
                ),
              );
            }).toList(),
          )),
    );
  }

  /// Fetch Current Currency
  Future<Currency> getCurrencies() async {
    setState(() {
      screenLoading = true;
    });
    await api.fetchCurrency().then((currencies) {
      if (currencies != null) {
        _laundryProvider.setCurrency(currencies);
        setState(() {
          screenLoading = false;
        });
        return currencies;
      }
    });
    return null;
  }

  /// Fetch Categories
  Future<CategoryList> getCategories() async {
    setState(() {
      screenLoading = true;
    });

    await api.fetchCategories().then((categories) {
      if (categories != null) {
        final cc = categories;
        print('LENGTH OF CAT ${categories.category.length}');
        _laundryProvider.setCategories(cc.category);
        setState(() {
          screenLoading = false;
        });
        return categories;
      }
    }).catchError((error) {
      print('ERROR CAUGHT $error');
      // setState(() {
      //   loading = false;
      // });
      // globalKey.currentState.showSnackBar(Loaders.maidokiSnackbar(
      //   fontSize: 15.0,
      //   title: error.toString(),
      //   onClick: SnackBarAction(
      //     label: 'Dismiss',
      //     textColor: Colors.white,
      //     onPressed: () => {
      //       setState(() {
      //         loading = false;
      //       })
      //     },
      //   ),
      // ));
    });
    return null;
  }

  Future<CategoryList> getAllProducts() async {
    setState(() {
      screenLoading = true;
    });

    await api.fetchAllProducts().then((products) {
      if (products != null) {
        final all_products = products;
        // print('ALL PRODUCTS ARE ${all_products.product}');
        _laundryProvider.setProducts(all_products.product);
        setState(() {
          screenLoading = false;
        });
        return products;
      }
    }).catchError((error) {
      print('ERROR CAUGHT $error');
    });
    return null;
  }
}
