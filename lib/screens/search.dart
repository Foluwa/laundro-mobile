import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';
import '../providers/laundry_provider.dart';
import '../widgets/bottom_cart.dart';
import '../widgets/search_widget.dart';
import '../widgets/single_product.dart';

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
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF607D8B), title: buildSearch()),
      body: Column(
        children: <Widget>[
          Expanded(
              child: products.isEmpty
                  ? const Center(child: Text('No product found'))
                  : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return buildProduct(product);
                      },
                    )),
        ],
      ),
      bottomNavigationBar: const BottomCart(),
    );
  }

  /// Build the list of products
  Widget buildProduct(Product product) => SingleProduct(products: product);

  /// Search box
  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Start typing to search',
        onChanged: searchProduct,
      );

  /// Search functionality
  void searchProduct(String query) {
    final displayProducts = _laundryProvider.getProducts!.where((book) {
      final nameLower = book.name.toLowerCase();
      final descriptionLower = book.description.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower) ||
          descriptionLower.contains(searchLower);
    }).toList();
    if (mounted) {
      setState(() {
        this.query = query;
        products = displayProducts;
      });
    }
  }
}
