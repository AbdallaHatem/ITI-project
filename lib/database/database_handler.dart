import 'package:shopping_app/components/list.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../database/tables_classes.dart';

class DataBaseHandler {
  static Database? _db;
  static const String DATABASE = 'ShoppingApp.db';
  static const int VERSION = 1;

  Future<Database> get db async {
    if (_db == null) {
      String path = join(await getDatabasesPath(), DATABASE);
      _db = await openDatabase(path, version: VERSION, onCreate: _onCreate, onUpgrade: _onUpgrade);
    }
    return _db!;
  }

  _onCreate(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON');
    await createTables(db);
    await insertAllProducts(products, db);
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE IF EXISTS product');
    await db.execute('DROP TABLE IF EXISTS type');
    await db.execute('DROP TABLE IF EXISTS user');
    await db.execute('DROP TABLE IF EXISTS cart');
    await _onCreate(db, newVersion);
  }

  Future<void> removeCartItem(int userID, int productID) async {
    Database dbClient = await db;
    await dbClient.delete(
      'cart',
      where: 'userID = ? AND productID = ?',
      whereArgs: [userID, productID],
    );
  }

  static Future<void> createTables(Database db) async {
    await db.execute("CREATE TABLE type(id INTEGER PRIMARY KEY, name TEXT)");
    await db.execute('''
      CREATE TABLE product(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        typeID INTEGER,
        name TEXT,
        desc TEXT,
        price INTEGER,
        image TEXT,
        FOREIGN KEY (typeID) REFERENCES type(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        mail TEXT,
        pass TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE cart(
        userID INTEGER,
        productID INTEGER,
        FOREIGN KEY (userID) REFERENCES user(id),
        FOREIGN KEY (productID) REFERENCES product(id)
      )
    ''');
  }

  Future<void> insertAllProducts(List<Map<String, dynamic>> products, Database db) async {
    for (Map<String, dynamic> i in products) {
      product p = product(
          id: i['id'], typeID: i['typeID'], name: i['name'], desc: i['desc'], price: i['price'], image: i['image']);
      int id = await db.insert(
        'product',
        p.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      p.id = id;
    }
  }

  Future<void> insertProduct(product p) async {
    Database dbClient = await db;
    int id = await dbClient.insert(
      'product',
      p.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    p.id = id;
  }

  Future<List<product>> getAllProducts() async {
    Database dbClient = await db;
    final List<Map<String, dynamic>> productsn = await dbClient.query('product');
    return List.generate(productsn.length, (i) {
      return product(
        id: productsn[i]['id'],
        typeID: productsn[i]['typeID'],
        name: productsn[i]['name'],
        desc: productsn[i]['desc'],
        price: productsn[i]['price'],
        image: productsn[i]['image'],
      );
    });
  }

  Future<List<product>> getProductsById(List<int> ids) async {
    Database dbClient = await db;
    List<product> products = [];
    for (int id in ids) {
      final List<Map<String, dynamic>> productMaps = await dbClient.query('product', where: 'id = ?', whereArgs: [id]);
      if (productMaps.isNotEmpty) {
        products.add(product(
          id: productMaps[0]['id'],
          typeID: productMaps[0]['typeID'],
          name: productMaps[0]['name'],
          desc: productMaps[0]['desc'],
          price: productMaps[0]['price'],
          image: productMaps[0]['image'],
        ));
      }
    }
    return products;
  }

  Future<void> insertAllTypes(List<Map<String, dynamic>> types, Database db) async {
    for (Map<String, dynamic> i in types) {
      type t = type(id: i['id'], name: i['name']);
      await db.insert(
        'type',
        t.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> insertType(type t) async {
    Database dbClient = await db;
    await dbClient.insert(
      'type',
      t.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<type>> getAllTypes() async {
    Database dbClient = await db;
    final List<Map<String, dynamic>> types = await dbClient.query('type');
    return List.generate(types.length, (i) {
      return type(
        id: types[i]['id'],
        name: types[i]['name'],
      );
    });
  }

  Future<void> insertUser(user u) async {
    Database dbClient = await db;
    int id = await dbClient.insert(
      'user',
      u.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    u.id = id;
  }

  Future<user?> getUserByID(int id) async {
    Database dbClient = await db;
    final List<Map<String, dynamic>> mp = await dbClient.query(
      'user',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (mp.isNotEmpty) return user(id: mp[0]['id'], name: mp[0]['name'], mail: mp[0]['mail'], pass: mp[0]['pass']);
    return null;
  }

  Future<user?> getUserByMail(String Mail) async {
    Database dbClient = await db;
    final List<Map<String, dynamic>> mp = await dbClient.query(
      'user',
      where: 'mail = ?',
      whereArgs: [Mail],
      limit: 1,
    );
    if (mp.isEmpty) return null;
    return user(id: mp[0]['id'], name: mp[0]['name'], mail: mp[0]['mail'], pass: mp[0]['pass']);
  }

  Future<void> insertCart(int user_ID, int product_ID) async {
    Database dbClient = await db;
    cart c = cart(userID: user_ID, productID: product_ID);
    await dbClient.insert(
      'cart',
      c.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<cart>> getAllcart(int user_ID) async {
    Database dbClient = await db;
    final List<Map<String, dynamic>> carts = await dbClient.query(
      'cart',
      where: 'userID = ?',
      whereArgs: [user_ID],
    );
    return List.generate(carts.length, (i) {
      return cart(
        userID: carts[i]['userID'],
        productID: carts[i]['productID'],
      );
    });
  }
}