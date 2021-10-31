/// ProductList
class OrderProductList {
  List<OrderProduct> product;
  OrderProductList({required this.product});

  factory OrderProductList.fromJson(product) {
    print('INSIDE ProductList $product');
    final operations = product as List;
    print('operations $operations');
    final data = operations.map((f) => OrderProduct.fromJson(f)).toList();
    print('INSIDE ProductList data $data');
    print('INSIDE ProductList data ${data.length}');
    return OrderProductList(product: data);
  }
}

class OrderProduct {
  int id;
  String name;
  String description;
  double price;
  int sub_category_id;
  int qty;

  OrderProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.sub_category_id,
    required this.qty,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> product) {
    // print('PRICE: ${product['Price']}');
    return OrderProduct(
      id: product['id'],
      name: product['Name'],
      description: product['Description'],
      price: product['Price'].toDouble(),
      //sub_category_id: product['sub_category']['id'],
      qty: 0,
    );
  }

  OrderProduct.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        description = res['description'],
        price = res['price'],
        sub_category_id = res['sub_category_id'],
        qty = res['qty'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'sub_category_id': sub_category_id,
      'qty': qty
    };
  }

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'id: ${id}, name: $name, sub_category_id $sub_category_id, Quantity $qty';
  }
}
