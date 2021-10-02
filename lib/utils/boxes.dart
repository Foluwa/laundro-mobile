import 'package:hive/hive.dart';

import '../models/cart.dart';

class Boxes {
  static Box<CartDB> getCart() => Hive.box<CartDB>('cart');
  static Future clearCart() => Hive.box<CartDB>('cart').clear();
}
