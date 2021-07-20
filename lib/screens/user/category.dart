import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundro/utils/size_config.dart';
import 'package:provider/provider.dart';

import '../../api/laundry.dart';
import '../../models/categories.dart';
import '../../models/currency.dart';
import '../../providers/laundry_provider.dart';
import '../../utils/constants.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _laundryProvider = Provider.of<LaundryProvider>(context);

    print(SizeConfig.safeBlockHorizontal * 2.55);

    // print(
    //     'CURRENT CURRENCY ${_laundryProvider.getCurrency.currency}');

    // if (_laundryProvider.getCategories != null) {
    //   for (var e in _laundryProvider.getCategories) {
    //     print('Sub ${e.subCategory.name}');
    //   }
    // }

    if (_laundryProvider.getCategories == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
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
          // children: _laundryProvider.getCategories.map((title) {
          //   return ListView.builder(
          //       itemBuilder: (context, index) => ListTile(
          //             title: GestureDetector(
          //                 onTap: () {
          //                   Navigator.of(context)
          //                       .pushNamed('/category_details');
          //                 },
          //                 // ignore: lines_longer_than_80_chars
          //                 child: Text(_laundryProvider
          //                     .getCategories[index].)),
          //           ));
          // }).toList(),

          children: <Widget>[
            _buildListViewWithName('Incoming Call'),
            _buildListViewWithName('Outgoing Call'),
            _buildListViewWithName('Missed Call0'),
          ],
        ),
      ),
    );
  }

  ListView _buildListViewWithName(String s) {
    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
              title: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/category_details');
                  },
                  child: Card(child: Text(s + ' $index'))),
            ));
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

    print('FETCHING categories');
    await api.fetchCategories().then((categories) {
      if (categories != null) {
        print('categories $categories');
        final cc = categories;
        _laundryProvider.setCategories(cc.category);
        setState(() {
          screenLoading = false;
        });
        return categories;
      }
    });
    return null;
  }
}
