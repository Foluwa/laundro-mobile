// import 'location.dart';
// import 'product.dart';
//
// /// User [
// // [User] User [User making the request]
// // [String] Order Id
// // [String] Email Address
// // [String] First Name [User the request is being made for]
// // [String] Last Name
// // [Long Number] Phone Number
// // [String] Home Address
//
// /// Product
// // [Products] Products
//
// /// Location
// // [String] Home Region
// // ________________
// // [String] delivery Price
//
// /// ORDER
// // [String] Status
// // Delivery Address
// // Additional Notes
// // [Bool] isDropIn
// // [String] payment_method  (Platform)
// // ________________
// // [Double] Product Price
// // [Double] Total [Home Price + Product Price]
//
// // [String] Created_date
// // [String] Updated_date
//
// /// ProductList
// class OrderList {
//   List<Order> order;
//   OrderList({required this.order});
//
//   factory OrderList.fromJson(product) {
//     print('INSIDE OrderList $product');
//     final operations = product as List;
//     final data = operations.map((f) => Order.fromJson(f)).toList();
//     return OrderList(order: data);
//   }
// }
//
// class Order {
//   int id;
//   String order_id;
//   String payment_method;
//   Location user_location;
//   double total_price;
//   double delivery_price;
//   String additional_notes;
//   String delivery_address;
//   String delivery_pickup_time;
//   bool is_drop_in;
//   bool drop_in_time;
//   Product product;
//   //User user;
//
//   Order({
//     required this.id,
//     required this.order_id,
//     required this.description,
//     required this.price,
//     required this.sub_category_id,
//     required this.qty,
//   });
//
//   factory Order.fromJson(Map<String, dynamic> order) {
//     // print('PRICE: ${product['Price']}');
//     return Order(
//       id: order['id'],
//       name: order['Name'],
//       description: order['Description'],
//       price: order['Price'].toDouble(),
//       sub_category_id: order['sub_category']['id'],
//       qty: 0,
//     );
//   }
//
//   Order.fromMap(Map<String, dynamic> res)
//       : id = res['id'],
//         name = res['name'],
//         description = res['description'],
//         price = res['price'],
//         sub_category_id = res['sub_category_id'],
//         qty = res['qty'];
//
//   Map<String, Object?> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'price': price,
//       'sub_category_id': sub_category_id,
//       'qty': qty
//     };
//   }
//
//   @override
//   String toString() {
//     // ignore: lines_longer_than_80_chars
//     return 'id: ${id}, name: $name, sub_category_id $sub_category_id, Quantity $qty';
//   }
// }
