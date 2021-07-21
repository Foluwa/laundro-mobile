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
  int sub_category_id;

  Product({
    this.id,
    this.name,
    this.description,
    // this.price,
    // this.sub_category,
    this.sub_category_id,
  });

  factory Product.fromJson(Map<String, dynamic> product) {
    return Product(
      id: product['id'],
      name: product['Name'],
      description: product['Description'],
      // price: product['Price'],
      // sub_category: product['sub_category'],
      sub_category_id: product['sub_category']['id'],
    );
  }

  @override
  String toString() {
    return 'id: ${id}, name: ${name}, sub_category_id ${sub_category_id}';
  }
}
