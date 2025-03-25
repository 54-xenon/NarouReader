// database/database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/savedList_modell.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  // データベースを取得するメソッド
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // データベースの初期化
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,

    );
  }

  // データベースのテーブル作成
  Future _onCreate(Database db, int version) async {
    await db.execute(
        // データテーブル
        // 項目の一番最後はカンマを付けないようにする(コンソールにエラーが出る)
        '''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        ncode TEXT,
        story TEXT
      )
      ''');
  }

  // データを挿入
  Future<int> insertItem(Item item) async {
    final db = await database;
    return await db.insert('items', item.toMap());
  }

  // データを取得
  Future<List<Item>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('items');

    return List.generate(maps.length, (i) {
      return Item.fromMap(maps[i]);
    });
  }

  // データを更新
  Future<int> updateItem(Item item) async {
    final db = await database;
    return await db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  // データを削除
  Future<int> deleteItem(String ncode) async {  //数字ではなく文字なのでString型に修正
    final db = await database;
    return await db.delete(
      'items',
      where: 'ncode = ?',
      whereArgs: [ncode],
    );
  }

  // 全てのデータを削除するメソッド
  Future<int> deleteAllItems() async {
    final db = await database;
    return await db.delete('items');
  }

}
