import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/products.dart';
import '../../providers/laundry_provider.dart';
import '../../widgets/bottom_cart.dart';
import '../../widgets/search_widget.dart';
import '../../widgets/single_product.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Product> products;
  String query = '';
  LaundryProvider _laundryProvider = LaundryProvider();

  @override
  void initState() {
    super.initState();
    products = _laundryProvider.getProducts!;
  }

  @override
  Widget build(BuildContext context) {
    _laundryProvider = Provider.of<LaundryProvider>(context);
    print('QUERY $query');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF607D8B),
        title: buildSearch(),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: products.isEmpty
                  ? const Center(child: Text('no product found'))
                  : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return buildproduct(product);
                      },
                    )),
        ],
      ),
      bottomNavigationBar: const BottomCart(),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Product name or description',
        onChanged: searchProduct,
      );

  // Widget buildproduct(Product product) => ListTile(
  //       // leading: Image.network(
  //       //   book.urlImage,
  //       //   fit: BoxFit.cover,
  //       //   width: 50,
  //       //   height: 50,
  //       // ),
  //       title: Text(product.name),
  //       // subtitle: Text(product.name),
  //       subtitle: _laundryProvider.inCart(product.id)
  //           ? Row(
  //               children: [
  //                 IconButton(
  //                   onPressed: () {
  //                     // add item into basket
  //                     print('add item into basket');
  //                     Product dd = product;
  //                     _laundryProvider.addOneItemToCart(dd);
  //                   },
  //                   icon: const Icon(Icons.add),
  //                   iconSize: 20,
  //                 ),
  //                 Text(
  //                     // ignore: lines_longer_than_80_chars
  //                     '${_laundryProvider.inCartQty(product.id)}'),
  //                 IconButton(
  //                   onPressed: () {
  //                     // remove item from basket
  //                     _laundryProvider.removeOneItemToCart(product);
  //                   },
  //                   icon: const Icon(Icons.remove),
  //                   iconSize: 20,
  //                 )
  //               ],
  //             )
  //           : IconButton(
  //               onPressed: () {
  //                 // add item into basket
  //                 print('add item into cart basket');
  //                 _laundryProvider.addOneItemToCart(product);
  //                 _laundryProvider.getBasketQty();
  //                 _laundryProvider.getTotalPrice();
  //               },
  //               icon: const Icon(Icons.ac_unit_outlined),
  //               iconSize: 20,
  //             ),
  // );

  Widget buildproduct(Product product) => SingleProduct(products: product);

  void searchProduct(String query) {
    final displayProducts = _laundryProvider.getProducts!.where((book) {
      final nameLower = book.name.toLowerCase();
      final descriptionLower = book.description.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) ||
          descriptionLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      products = displayProducts;
    });
  }
}
