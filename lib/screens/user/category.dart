import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundro/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../api/laundry.dart';
import '../../models/categories.dart';
import '../../models/currency.dart';
import '../../models/products.dart';
import '../../providers/laundry_provider.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../../widgets/bottom_cart.dart';
import '../../widgets/common.dart';
import '../../widgets/loading_list.dart';
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
  UserProvider _userProvider = UserProvider();
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  bool screenLoading = true;
  late List<Category>? subCategories;

  @override
  void initState() {
    super.initState();
    getCurrencies().then((_) => print('fetch currency'));
    getCategories().then((_) => print('fetch categories'));
    getAllProducts().then((_) => print('fetch products'));

    ///Todo validate the jwt in shared preference
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _userProvider = Provider.of<UserProvider>(context);
    var user = _userProvider.getUser;
    print('USER $user');
    _laundryProvider = Provider.of<LaundryProvider>(context);
    subCategories = _laundryProvider.getCategories;

    // print('CURRENT CURRENCY ${_laundryProvider!.getCurrency!.currency}');
    return DefaultTabController(
      //length: _laundryProvider.getCategories?.length ?? 0,
      length: subCategories!.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Constants.primaryColor,
          title: Text(Constants.appName),
          // toolbarHeight: subCategories!.length < 1 ? 70 : null,
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).pushNamed('/search'),
                icon: const Icon(Icons.search)),
            user != null
                ? IconButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/order_history'),
                    icon: const Icon(Icons.history))
                : SizedBox(),
            IconButton(
                onPressed: () => Navigator.of(context).pushNamed('/account'),
                icon: const Icon(Icons.person)),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorWeight: SizeConfig.safeBlockHorizontal * 1,
            indicatorColor: Constants.white,
            tabs: _laundryProvider.getCategories!.map((title) {
              return subCategories!.length < 1
                  ? Container()
                  : Tab(
                      icon: const Icon(Icons.local_laundry_service_outlined),
                      // text: title.Name,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(title.Name,
                              style: TextStyle(
                                color: Constants.white,
                                fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                                fontWeight: FontWeight.w500,
                              ))));
            }).toList(),
          ),
        ),
        body: subCategories!.length < 1
            ? const Center(child: LoadingListPage())
            : TabBarView(
                //children: _laundryProvider.getCategories!.map((item) {
                children: subCategories!.map((item) {
                return RefreshWidget(
                  keyRefresh: RIKeys.riKey1, // keyRefresh,
                  onRefresh: callAllApis, //getCategories,
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
                                      onTap: () => Navigator.of(context)
                                          .pushNamed('/category_details',
                                              arguments: item.subCategory
                                                  .subcategory[index]),
                                      child: Stack(children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height:
                                              SizeConfig.safeBlockHorizontal *
                                                  51,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fitWidth,
                                              image: NetworkImage(item
                                                  .subCategory
                                                  .subcategory[index]
                                                  .img_url),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            bottom:
                                                // ignore: lines_longer_than_80_chars
                                                SizeConfig.safeBlockHorizontal *
                                                    6.37,
                                            left:
                                                // ignore: lines_longer_than_80_chars
                                                SizeConfig.safeBlockHorizontal *
                                                    3.85,
                                            child: Row(
                                              children: [
                                                Text(
                                                    item
                                                        .subCategory
                                                        .subcategory[index]
                                                        .name,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: Constants.white,
                                                      fontSize: SizeConfig
                                                              // ignore: lines_longer_than_80_chars
                                                              .safeBlockHorizontal *
                                                          5.1,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ))
                                              ],
                                            ))
                                      ]))))),
                );
              }).toList()),
        bottomNavigationBar: const BottomCart(),
      ),
    );
  }

  Future callAllApis() {
    // Refresh
    getCurrencies().then((_) => print('fetch currency'));
    getCategories().then((_) => print('fetch categories'));
    return getAllProducts().then((_) => print('fetch products'));
  }

  /// Fetch Current Currency
  Future<Currency> getCurrencies() async {
    if (mounted) {
      setState(() {
        screenLoading = true;
      });
    }
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
    if (mounted) {
      setState(() {
        screenLoading = true;
      });
    }

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
    }).catchError((error) {
      print('ERROR CAUGHT $error');
      Common.showSnackBar(context, title: error.toString(), duration: 3000);
      // return error;
    });
    return data;
  }

  Future<ProductList> getAllProducts() async {
    if (mounted) {
      setState(() {
        screenLoading = true;
      });
    }

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
      print('ERROR CAUGHT ${error}');
      Common.showSnackBar(context, title: error.toString(), duration: 300);
      // return error;
    });
    return data;
  }
}
