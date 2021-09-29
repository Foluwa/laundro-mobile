class OrderList {
  List<Order> orders;
  OrderList({required this.orders});
  factory OrderList.fromJson(category) {
    final operations = category as List;
    print('INSIDE OrderListOperations $operations');
    final data = operations.map((f) => Order.fromJson(f)).toList();
    return OrderList(orders: data);
  }
}

class Order {
  // int id;
  String orderId;
  String orderFirstName;
  String orderLastName;
  String orderPhoneNumber;
  String orderAddress;
  String orderNotes;
  String deliveryAddress;
  String deliveryPickupTime;
  String dropInTime;
  String paymentMethod;
  String status;
  double totalPrice;
  double deliveryPrice;
  //Location deliveryLocation;
  // ProductList products;
  // User user;
  String publishedAt;
  String createdAt;
  String updatedAt;

  Order({
    required this.orderId,
    required this.orderFirstName,
    required this.orderLastName,
    required this.orderPhoneNumber,
    required this.orderAddress,
    required this.orderNotes,
    required this.deliveryAddress,
    required this.deliveryPickupTime,
    required this.dropInTime,
    required this.paymentMethod,
    required this.status,
    required this.totalPrice,
    required this.deliveryPrice,
    //required this.deliveryLocation,
    // required this.products,
    // required this.user,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(order) {
    print('INSIDE FROMJSON $order');
    return Order(
      orderId: order['order_id'] ?? '',
      orderFirstName: order['order_first_name'] ?? '',
      orderLastName: order['order_last_name'] ?? '',
      orderPhoneNumber: order['order_phone_number'] ?? '',
      orderAddress: order['order_address'] ?? '',
      orderNotes: order['order_notes'] ?? '',
      deliveryAddress: order['delivery_address'] ?? '',
      deliveryPickupTime: order['delivery_pickup_time'] ?? '',
      dropInTime: order['drop_in_time'] ?? '',
      paymentMethod: order['payment_method'] ?? '',
      status: order['status'] ?? '',
      totalPrice: order['total_price'].toDouble() ?? '',
      deliveryPrice: order['delivery_price'].toDouble() ?? '',
      //deliveryLocation: order['delivery_location'] ?? '',
      // products: order['products'] ?? '',
      // user: order['user'] ?? '',
      publishedAt: order['published_at'] ?? '',
      createdAt: order['created_at'] ?? '',
      updatedAt: order['updated_at'] ?? '',
    );
  }

  // Map toJson(){
  //   Map<String, dynamic> data = {
  //     'bank': this.bank,
  //     'user_id': this.userId,
  //     'bank_account': this.bankAccount,
  //     'bank_code': this.bankCode,
  //     'processor_transfer_code': this.processorTransferCode,
  //
  //   };
  //   //extract keys without null data
  //
  //   data.removeWhere((key, value) => key == null || value == null);
  //
  //
  //   return data;
  // }

  @override
  String toString() {
    return 'id: ${orderId}, name: ${orderFirstName}';
  }
}
