/// ProductList
class ProductList {
  List<Product> product;
  ProductList({this.product});

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
  // double price;
  // SubCategory sub_category;

  Product({
    this.id,
    this.name,
    this.description,
    // this.price,
    // this.sub_category,
  });

  factory Product.fromJson(Map<String, dynamic> product) {
    return Product(
      id: product['id'],
      name: product['Name'],
      description: product['Description'],
      // price: product['Price'],
      // sub_category: product['sub_category'],
    );
  }

  @override
  String toString() {
    return 'id: ${id}, name: ${name}';
  }
}
