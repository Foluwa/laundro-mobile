import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/products.dart';

class PersistBasketDB {
  late Future<Database> database;

  Future<Database> initializeDB() async {
    var path = await getDatabasesPath();
    return openDatabase(
      join(path, 'persist_product_basket_01.db'),
      onCreate: (database, version) async {
        await database.execute(
          // ignore: lines_longer_than_80_chars
          //'CREATE TABLE users(id INTEGER PRIMARY KEY NOT NULL, name TEXT NOT NULL,description TEXT NOT NULL,price DOUBLE NOT NULL,sub_category_id INTEGER NOT NULL,qty INTEGER NOT NULL)',
          // ignore: lines_longer_than_80_chars
          'CREATE TABLE users(id INTEGER PRIMARY KEY NOT NULL, qty INTEGER NOT NULL)',
        );
      },
      version: 1,
    );
  }

  // Saving Data in SQLite
  Future<int> insertProducts(List<Product> products) async {
    var result = 0;
    final db = await initializeDB();
    for (final product in products) {
      result = await db.insert('products', product.toMap());
    }
    return result;
  }

  // Retrieve Data From SQLite
  Future<List<Product>> retrieveProducts() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('products');
    return queryResult.map((e) => Product.fromMap(e)).toList();
  }

  // Delete Data From SQLite
  Future<void> deleteProduct(int id) async {
    final db = await initializeDB();
    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Update product
}
