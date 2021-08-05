// https://educity.app/flutter/the-right-way-to-use-sqlite-in-flutter-apps-using-sqflite-package-with-examples

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDB {
  static final SqliteDB _instance = SqliteDB.internal();

  factory SqliteDB() => _instance;
  late Database _db;

  Future<Database> get db async {
    // ignore: unnecessary_null_comparison
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  SqliteDB.internal();

  /// Initialize DB
  Future<Database> initDb() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'myDatabase.db');
    final taskDb = await openDatabase(path, version: 1);
    return taskDb;
  }

  /// Count number of tables in DB
  Future countTable() async {
    final dbClient = await db;
    final res =
        await dbClient.rawQuery("""SELECT count(*) as count FROM sqlite_master
         WHERE type = 'table' 
         AND name != 'android_metadata' 
         AND name != 'sqlite_sequence';""");
    return res[0]['count'];
  }

  /// Creates products Table
  Future createUserTable() async {
    final dbClient = await SqliteDB().db;
    final res = await dbClient.execute('''
       CREATE TABLE Product(id INTEGER PRIMARY KEY NOT NULL, name TEXT NOT NULL,description TEXT NOT NULL,price DOUBLE NOT NULL,sub_category_id INTEGER NOT NULL,qty INTEGER NOT NULL)''');
    return res;
  }

  /// Add user to the table
  Future putUser() async {
    /// User data
    final dynamic product = {
      'id': 'johndoe94',
      'name': 'ppppoe',
      'description': 'description',
      'price': 26.0,
      'sub_category_id': 1,
      'qty': 1
    };

    /// Adds user to table
    final dbClient = await SqliteDB().db;
    final res = await dbClient.insert('Product', product);
    return res;
  }

  /// Get all using sqflite helper
  Future getAllUsingHelper() async {
    final dbClient = await SqliteDB().db;
    final res = await dbClient.query('Product');
    return res;
  }

  Future update(newQty, id) async {
    final dbClient = await SqliteDB().db;
    final res = await dbClient.rawQuery(""" UPDATE Product 
        SET qty = newQty WHERE id = '$id'; """);
    return res;
  }

  /// Delete data using raw query
  Future delete(id) async {
    final dbClient = await SqliteDB().db;
    final res = await dbClient.rawQuery("""DELETE FROM Product 
                    WHERE id = '$id'; """);
    return res;
  }
}

//
// class PersistBasketDB {
//   late Future<Database> database;
//
//   Future<Database> initializeDB() async {
//     var path = await getDatabasesPath();
//     return openDatabase(
//       join(path, 'persist_product_basket_01.db'),
//       onCreate: (database, version) async {
//         await database.execute(
//           // ignore: lines_longer_than_80_chars
//           //'CREATE TABLE users(id INTEGER PRIMARY KEY NOT NULL, name TEXT NOT NULL,description TEXT NOT NULL,price DOUBLE NOT NULL,sub_category_id INTEGER NOT NULL,qty INTEGER NOT NULL)',
//           // ignore: lines_longer_than_80_chars
//           'CREATE TABLE products(id INTEGER PRIMARY KEY NOT NULL, qty INTEGER NOT NULL)',
//         );
//       },
//       version: 1,
//     );
//   }
//
//   // Saving Data in SQLite
//   Future<int> insertProducts(List<Product> products) async {
//     var result = 0;
//     final db = await initializeDB();
//     for (final product in products) {
//       result = await db.insert('products', product.toMap());
//     }
//     return result;
//   }
//
//   // Retrieve Data From SQLite
//   Future<List<Product>> retrieveProducts() async {
//     final Database db = await initializeDB();
//     final List<Map<String, Object?>> queryResult = await db.query('products');
//     return queryResult.map((e) => Product.fromMap(e)).toList();
//   }
//
//   // Delete Data From SQLite
//   Future<void> deleteProduct(int id) async {
//     final db = await initializeDB();
//     await db.delete(
//       'products',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//
//   // Update product
// }
