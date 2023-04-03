import 'package:metuverse/new_buy_sell/controllers/storage/database/SellBuyTableValues.dart';
import 'package:metuverse/storage/database/database_helper_post/BasePostTableValues.dart';
import 'package:metuverse/storage/database/database_photo/DatabasePhotoTableValues.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperParent {
  final databaseName = "Metuverse.db";
  int databaseVersion = 1;
  late Database db;
  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async{
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, databaseName);
    db = await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }
  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON;');
    await db.execute('''
          CREATE TABLE ${BasePostTableValues.table} (
            ${BasePostTableValues.columnPostID} INTEGER UNSIGNED PRIMARY KEY
          )
          ''');
    await db.execute('''
          CREATE TABLE ${SellBuyTableValues.table} (
            ${SellBuyTableValues.columnPostID} INTEGER UNSIGNED PRIMARY KEY,
            ${SellBuyTableValues.columnFullName} TEXT NOT NULL,
            ${SellBuyTableValues.columnProfilePicture} TEXT,
            ${SellBuyTableValues.columnBelongToUser} INTEGER NOT NULL,
            ${SellBuyTableValues.columnUpdateVersion} INTEGER UNSIGNED NOT NULL,
            ${SellBuyTableValues.columnMedia} TEXT,
            ${SellBuyTableValues.columnDescription} TEXT,
            ${SellBuyTableValues.columnProductPrice} INTEGER UNSIGNED,
            ${SellBuyTableValues.columnCurrency} TEXT,
            ${SellBuyTableValues.columnProductStatus} INTEGER UNSIGNED NOT NULL,
            FOREIGN KEY (${SellBuyTableValues.columnPostID}) REFERENCES ${BasePostTableValues.table}(${BasePostTableValues.columnPostID})
            ON DELETE CASCADE
          )
          ''');
          await db.execute('''
            CREATE TABLE IF NOT EXISTS ${DatabasePhotoTableValues.table} (
              ${DatabasePhotoTableValues.columnPhotoID} INTEGER PRIMARY KEY AUTOINCREMENT,
              ${DatabasePhotoTableValues.columnPostID} INTEGER UNSIGNED,
              ${DatabasePhotoTableValues.columnPhotoSource} TEXT,
              ${DatabasePhotoTableValues.columnPhotoData} BLOB,
              ${DatabasePhotoTableValues.columnInsertionDate} DATE,
              FOREIGN KEY (${DatabasePhotoTableValues.columnPostID}) REFERENCES ${BasePostTableValues.table}(${BasePostTableValues.columnPostID})
              ON DELETE CASCADE
            )
            '''
          );


  }
}