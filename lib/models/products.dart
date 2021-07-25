/// ProductList
class ProductList {
  List<Product> product;
  ProductList({required this.product});

  factory ProductList.fromJson(product) {
    print('INSIDE ProductList $product');
    final operations = product as List;
    final data = operations.map((f) => Product.fromJson(f)).toList();
    return ProductList(product: data);
  }
}

class Product {
  int id;
  String name;
  String description;
  double price;
  // SubCategory sub_category;
  int sub_category_id;
  int qty;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    // this.sub_category,
    required this.sub_category_id,
    required this.qty,
  });

  factory Product.fromJson(Map<String, dynamic> product) {
    // print('PRICE: ${product['Price']}');
    return Product(
      id: product['id'],
      name: product['Name'],
      description: product['Description'],
      price: product['Price'].toDouble(),
      // sub_category: product['sub_category'],
      sub_category_id: product['sub_category']['id'],
      qty: 0,
    );
  }

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'id: ${id}, name: $name, sub_category_id $sub_category_id, Quantity $qty';
  }
}
