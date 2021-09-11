import 'package:hive/hive.dart';

part 'cart.g.dart';

@HiveType(typeId: 0)
class CartDB extends HiveObject {
  @HiveField(0)
  late int productId;

  @HiveField(1)
  late int qty;
}
