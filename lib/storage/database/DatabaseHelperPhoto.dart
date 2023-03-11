import 'dart:typed_data';

import 'package:metuverse/storage/database/DatabaseHelper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
class DatabaseHelperPhoto extends DatabaseHelper{
  //table name
  static const table = 'photos';
  //column names
  static const columnPhotoID = '_photoID';
  static const columnPostID = 'postID';
  static const columnPhotoData = 'photoData';
  //other table data
  static const otherTable = 'buy_sell_posts';
  static const columnOtherTablePostID = '_postID';

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, databaseName);
    db = await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
    await _onCreate(db, databaseVersion);
  }
  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON;');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $table (
        $columnPhotoID INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnPostID INTEGER UNSIGNED,
        $columnPhotoData BLOB,
        FOREIGN KEY ($columnPostID) REFERENCES $otherTable($columnOtherTablePostID)
        ON DELETE CASCADE
      )
      '''
    );
  }
  Future<int> insertPhotoFromUrl(postID,String url) async {
    final response = await http.get(Uri.parse(url));
    final photoData = response.bodyBytes;
    final row = {
      columnPhotoID: 1,
      columnPostID: postID,
      columnPhotoData: photoData,
    };
    //return await db.insert('$table', {'$columnPostID':postID,'$columnPhotoData': photoData});
    return await db.insert(table, row);
  }
  Future<List<Uint8List>?> getAllPhotosWithPostID(postID) async {
    final photosData = await db.query(table,
        where: '$columnPostID = ?',
        whereArgs: [postID]);

    if(photosData.length == 0)
      return null;
    else
      return photosData.map((photoData) {
        final bytes = photoData['data'] as Uint8List;
        return bytes;
      }).toList();
  }

  //debug purpose
  Future<List<Uint8List>> getAllPhotosInDB() async {
    final photosData = await db.query('photos');

    return photosData.map((photoData) {
      final bytes = photoData['data'] as Uint8List;
      return bytes;
    }).toList();
  }
}
