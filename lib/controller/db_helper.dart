import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/gifter_model.dart';


class DBHelper{
  static Database? _database;

  Future<Database?> get db async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDataBase();
    return _database;
  }

  initDataBase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'gifter.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE gifts (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,gender TEXT,giftType TEXT, amount TEXT, giftName TEXT, date DATE)');
  }

  Future<GifterModel> insertData(GifterModel gifterModel) async {
    var dbclient = await db;
    await dbclient!.insert('gifts', gifterModel.toMap());
    return gifterModel;
  }

  Future<List<GifterModel>> getGiftData() async {
    var dbclient = await db;
    final List<Map<String, Object?>> queryresult =
    await dbclient!.query("gifts");
    return queryresult.map((e) => GifterModel.fromMap(e)).toList();
  }

  Future<int> delete(dynamic id) async {
    var dbClient = await db;
    return await dbClient!.delete('gifts', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updatedQuantity(GifterModel gifterModel) async {
    var dbClient = await db;
    return await dbClient!
        .update('gifts', gifterModel.toMap(), where: 'id= ?', whereArgs: [gifterModel.id]);
  }
}