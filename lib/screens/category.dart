import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/laundry.dart';
import '../api/user.dart';
import '../models/category.dart';
import '../models/currency.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../providers/laundry_provider.dart';
import '../providers/user_provider.dart';
import '../utils/boxes.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../widgets/bottom_cart.dart';
import '../widgets/common.dart';
import '../widgets/loading_list.dart';
import '../widgets/refresh_widget.dart';

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
  LaundryApi api = LaundryApi(addAccessToken: false);
  UserApi userApi = UserApi(addAccessToken: true);
  LaundryProvider _laundryProvider = LaundryProvider();
  UserProvider _userProvider = UserProvider();
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  bool screenLoading = true;
  late List<Category>? subCategories;

  @override
  void initState() {
    super.initState();
    getUser().then((_) => print('fetch user'));
    getCurrencies().then((_) => print('fetch currency'));
    getCategories().then((_) => print('fetch categories'));
    getAllProducts().then((_) => print('fetch products'));

    ///Todo validate the jwt in shared preference
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _userProvider = Provider.of<UserProvider>(context);
    final user = _userProvider.getUser;
    print('USER $user');
    _laundryProvider = Provider.of<LaundryProvider>(context);
    subCategories = _laundryProvider.getCategories;

    print('SUBCATEGORY $subCategories');

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
                : const SizedBox(),
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
                      // // icon: const Icon(Icons.local_laundry_service_outlined),
                      // icon: Image.network(
                      //   'https://img.icons8.com/external-kiranshastry-lineal-color-kiranshastry/2x/external-laundry-hygiene-kiranshastry-lineal-color-kiranshastry-2.png',
                      //   width: 40.0,
                      //   height: 40.0,
                      // ),
                      // // text: 'laundry image',
                      // // text: title.Name,
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

                ///children: _laundryProvider.getCategories!.map((item) {
                children: subCategories!.map((item) {
                return RefreshWidget(
                  keyRefresh: RIKeys.riKey1,
                  onRefresh: callAllApis,
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
                                    arguments:
                                        item.subCategory.subcategory[index]),
                                child: Stack(children: [
                                  Container(
                                      child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height:
                                              SizeConfig.safeBlockHorizontal *
                                                  51,
                                          child: FadeInImage.assetNetwork(
                                              image: item.subCategory
                                                  .subcategory[index].img_url,
                                              placeholder: 'assets/spinner.gif',
                                              fit: BoxFit.cover)),
                                      foregroundDecoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                            Color(0xCC000000),
                                            Color(0x00000000),
                                            Color(0x00000000),
                                            Color(0xCC000000),
                                          ])),
                                      width: double.infinity),
                                  Positioned(
                                      // ignore: lines_longer_than_80_chars
                                      bottom:
                                          SizeConfig.safeBlockHorizontal * 6.37,
                                      left:
                                          // ignore: lines_longer_than_80_chars
                                          SizeConfig.safeBlockHorizontal * 3.85,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                  '${item.subCategory.subcategory[index].name}',
                                                  style: TextStyle(
                                                    color: Constants.white,
                                                    fontSize: SizeConfig
                                                            .safeBlockHorizontal *
                                                        5.1,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text('Starting from \$100',
                                                  style: TextStyle(
                                                    color: Constants.white,
                                                    fontSize: SizeConfig
                                                            .safeBlockHorizontal *
                                                        5.1,
                                                    fontWeight: FontWeight.w500,
                                                  ))
                                            ],
                                          )
                                        ],
                                      ))
                                ]),
                              ),
                      ),
                    ),
                  ),
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

  /// Fetch User from JWT
  Future<User> getUser() async {
    print('USER_IN_CATEGORY');
    if (mounted) {
      setState(() {
        screenLoading = true;
      });
    }
    var data;
    // get jwt from sharedprerence
    print('AAAAAA');
    await userApi.fetchUser().then((user) {
      // check if user is not null
      print('USER_IN_CATEGORY2 $user');
      _userProvider.setCurrentUser(user);
      // if (user != null) {
      //   _userProvider.setCurrentUser(user);
      // }
      if (mounted) {
        setState(() {
          screenLoading = false;
        });
      }
      data = user;
    });
    return data;
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

      // Persist cart
      persistCart().then((_) => print('persist cart'));
    }).catchError((error) {
      print('ERROR CAUGHT ${error}');
      Common.showSnackBar(context, title: error.toString(), duration: 300);
      // return error;
    });
    return data;
  }

  Future persistCart() async {
    if (_laundryProvider.getProducts != null) {
      final cartData = Boxes.getCart();
      // print('MAC CART KEYs IS ${cartData.keys}');
      // print('MAC CART Values IS ${cartData.values.length}');
      // print('MAC CART FIRST IS ${cartData.values.first}');
      // print('MAC CART FIRST IS ${cartData.values.first.productId}');
      // print('MAC CART FIRST IS ${cartData.values.first.qty}');
      // print('MAC CART DB  ${cartData}');

      final _baskets = <Product>[];
      for (final inCart in cartData.values) {
        if (inCart.qty > 0) {
          final retrievedData = _laundryProvider.getProducts!
              .firstWhere((i) => i.id == inCart.productId);
          retrievedData.qty = inCart.qty;
          print('retrievedData $retrievedData');
          _baskets.add(retrievedData);
        }
      }

      /// persist cart
      _laundryProvider.persistBasket(_baskets);
    }
  }
}
