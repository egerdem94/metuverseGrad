/*
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:metuverse/storage/database/DatabaseHelperParent.dart';
import 'package:metuverse/storage/models/Photo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PhotoDatabase{
  static final PhotoDatabase instance = PhotoDatabase._init();
  static Database? _database;
  static const databaseName = "photosDB";
  static const databaseVersion = 1;


  PhotoDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, databaseName);

    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE photos (
        id INTEGER PRIMARY KEY,
        data BLOB
      )
    ''');
  }

  Future<int> insertPhotoFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    final photoData = response.bodyBytes;

    final db = await instance.database;
    return await db.insert('photos', {'data': photoData});
  }


  Future<List<Uint8List>> getPhotos() async {
    final db = await instance.database;
    final photosData = await db.query('photos');

    return photosData.map((photoData) {
      final bytes = photoData['data'] as Uint8List;
      return bytes;
    }).toList();
  }
}
*/
