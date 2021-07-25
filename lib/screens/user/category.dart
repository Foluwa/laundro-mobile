import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/laundry.dart';
import '../../models/categories.dart';
import '../../models/currency.dart';
import '../../providers/laundry_provider.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../../widgets/bottom_cart.dart';
import '../../widgets/refresh_widget.dart';

class RIKeys {
  static const riKey1 = Key('__RIKEY1__');
  static const riKey2 = Key('__RIKEY2__');
  static const riKey3 = Key('__RIKEY3__');
}

class CategoryWidgetList extends StatefulWidget {
  const CategoryWidgetList({Key? key}) : super(key: key);

  @override
  _CategoryWidgetListState createState() => _CategoryWidgetListState();
}

class _CategoryWidgetListState extends State<CategoryWidgetList> {
  LaundryApi api = LaundryApi();
  LaundryProvider _laundryProvider = LaundryProvider();
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  bool screenLoading = true;

  @override
  void initState() {
    super.initState();
    getCurrencies().then((_) => print('fetch currency'));
    getCategories().then((_) => print('fetch categories'));
    getAllProducts().then((_) => print('fetch products'));

    ///
    // getCurrencies(); // .then((_) => print('fetch currency'));
    // getCategories(); //.then((_) => print('fetch categories'));
    // getAllProducts(); //.then((_) => print('fetch products'));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _laundryProvider = Provider.of<LaundryProvider>(context);

    // print('CURRENT CURRENCY ${_laundryProvider!.getCurrency!.currency}');
    return DefaultTabController(
      length: _laundryProvider.getCategories?.length ?? 0,
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
            indicatorWeight: 10.0, //SizeConfig.safeBlockHorizontal * 2.55, //
            indicatorColor: Colors.black,
            tabs: _laundryProvider.getCategories!.map((title) {
              return Tab(
                icon: const Icon(Icons.local_laundry_service_outlined),
                text: title.Name,
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: _laundryProvider.getCategories!.map((item) {
            return RefreshWidget(
              keyRefresh: RIKeys.riKey1, // keyRefresh,
              onRefresh: getCategories,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: item.subCategory.subcategory.length,
                itemBuilder: (context, index) => MediaQuery(
                  data: const MediaQueryData(padding: EdgeInsets.zero),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.only(left: 0.0, right: 0.0),
                    title: item.subCategory.subcategory.isEmpty
                        //TODO: Check if empty and display no product
                        ? InkWell(
                            onTap: () => null,
                            child: const Center(child: Text('Empty')))
                        : InkWell(
                            onTap: () => Navigator.of(context).pushNamed(
                                '/category_details',
                                arguments: item.subCategory.subcategory[index]),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 170,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(item
                                      .subCategory.subcategory[index].img_url),
                                ),
                              ),
                              child: Text(
                                  item.subCategory.subcategory[index].name),
                            ),
                          ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        bottomNavigationBar: const BottomCart(),
      ),
    );
  }

  /// Fetch Current Currency
  Future<Currency> getCurrencies() async {
    setState(() {
      screenLoading = true;
    });
    var data;
    await api.fetchCurrency().then((currencies) {
      _laundryProvider.setCurrency(currencies);
      setState(() {
        screenLoading = false;
      });
      data = currencies;
      //return currencies;
    });
    return data;
  }

  /// Fetch Categories
  Future<CategoryList> getCategories() async {
    print('CALLING getCategories');
    setState(() {
      screenLoading = true;
    });

    var data;
    await api.fetchCategories().then((categories) {
      final cc = categories;
      print('LENGTH OF CAT ${categories.category.length}');
      _laundryProvider.setCategories(cc.category);
      setState(() {
        screenLoading = false;
      });
      //return categories;
      data = categories;
    });
    return data;
  }

  Future<CategoryList> getAllProducts() async {
    setState(() {
      screenLoading = true;
    });

    var data;
    await api.fetchAllProducts().then((products) {
      final all_products = products;
      // print('ALL PRODUCTS ARE ${all_products.product}');
      _laundryProvider.setProducts(all_products.product);
      setState(() {
        screenLoading = false;
      });
      data = products;
      //return products;
    }).catchError((error) {
      print('ERROR CAUGHT $error');
      // return error;
    });
    return data;
  }
}
