import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/db/SellBuyTableValues.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/controller/storage/database/TransportationPostTableValues.dart';
import 'package:metuverse/screens/sport/sport_main/controller/db/SportTableValues.dart';
import 'package:metuverse/screens/whisper/whisper_main/controller/storage/database/WhisperPostTableValues.dart';
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
  Future<void> init() async {
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
    //TODO Batuhan 5 postla limitliyor 5 rastgele gormemiz icin
    await db.execute(''' 
    CREATE TRIGGER delete_oldest_post
          AFTER INSERT ON ${BasePostTableValues.table}
          WHEN (SELECT COUNT(*) FROM ${BasePostTableValues.table}) > 5
          BEGIN
            DELETE FROM ${BasePostTableValues.table}
            WHERE ${BasePostTableValues.columnPostID} = (
              SELECT MAX(${BasePostTableValues.columnPostID}) FROM ${BasePostTableValues.table}
            );
          END;
        ''');
    await db.execute('''
          CREATE TABLE ${SellBuyTableValues.table} (
            ${SellBuyTableValues.columnPostID} INTEGER UNSIGNED PRIMARY KEY,
            ${SellBuyTableValues.columnFullName} TEXT NOT NULL,
            ${SellBuyTableValues.columnProfilePicture} TEXT,
            ${SellBuyTableValues.columnBelongToUser} INTEGER NOT NULL,
            ${SellBuyTableValues.columnIsFavorite} INTEGER NOT NULL,
            ${SellBuyTableValues.columnPublicToken} TEXT,
            ${SellBuyTableValues.columnUpdateVersion} INTEGER UNSIGNED NOT NULL,
            ${SellBuyTableValues.columnDescription} TEXT,
            ${SellBuyTableValues.columnProductPrice} INTEGER UNSIGNED,
            ${SellBuyTableValues.columnCurrency} TEXT,
            ${SellBuyTableValues.columnProductStatus} INTEGER UNSIGNED NOT NULL,
            ${SellBuyTableValues.columnMediaExist} INTEGER UNSIGNED NOT NULL,
            FOREIGN KEY (${SellBuyTableValues.columnPostID}) REFERENCES ${BasePostTableValues.table}(${BasePostTableValues.columnPostID})
            ON DELETE CASCADE
          )
          ''');

    await db.execute('''
          CREATE TABLE ${WhisperPostTableValues.table} (
            ${WhisperPostTableValues.columnPostID} INTEGER UNSIGNED PRIMARY KEY,
            ${WhisperPostTableValues.columnFullName} TEXT NOT NULL,
            ${WhisperPostTableValues.columnProfilePicture} TEXT,
            ${WhisperPostTableValues.columnBelongToUser} INTEGER NOT NULL,
            ${WhisperPostTableValues.columnIsFavorite} INTEGER NOT NULL,
            ${WhisperPostTableValues.columnUpdateVersion} INTEGER UNSIGNED NOT NULL,
            ${WhisperPostTableValues.columnDescription} TEXT,
            ${WhisperPostTableValues.columnPublicToken} TEXT,
            ${WhisperPostTableValues.columnCreateDate} DATE,
            ${WhisperPostTableValues.columnMediaExist} INTEGER UNSIGNED NOT NULL,
            FOREIGN KEY (${WhisperPostTableValues.columnPostID}) REFERENCES ${BasePostTableValues.table}(${BasePostTableValues.columnPostID})
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
            ''');
    await db.execute('''
            CREATE TABLE ${TransportationPostTableValues.table} (
              ${TransportationPostTableValues.columnPostID} INTEGER UNSIGNED PRIMARY KEY,
              ${TransportationPostTableValues.columnFullName} TEXT NOT NULL,
              ${TransportationPostTableValues.columnProfilePicture} TEXT,
              ${TransportationPostTableValues.columnBelongToUser} INTEGER NOT NULL,
              ${TransportationPostTableValues.columnIsFavorite} INTEGER NOT NULL,
              ${TransportationPostTableValues.columnPublicToken} TEXT,
              ${TransportationPostTableValues.columnUpdateVersion} INTEGER UNSIGNED NOT NULL,
              ${TransportationPostTableValues.columnDescription} TEXT,
              ${TransportationPostTableValues.columnProductPrice} INTEGER UNSIGNED,
              ${TransportationPostTableValues.columnCurrency} TEXT,
              ${TransportationPostTableValues.columnDepartureLocation} INTEGER,
              ${TransportationPostTableValues.columnDestinationLocation} INTEGER,
              ${TransportationPostTableValues.columnDepartureTime} DATE,
              ${TransportationPostTableValues.columnAvailablePerson} INTEGER UNSIGNED,
              ${TransportationPostTableValues.columnTotalPerson} INTEGER UNSIGNED,
              ${TransportationPostTableValues.columnTransportationStatus} INTEGER UNSIGNED,
              FOREIGN KEY (${TransportationPostTableValues.columnPostID}) REFERENCES ${BasePostTableValues.table}(${BasePostTableValues.columnPostID})
              ON DELETE CASCADE
            )
        ''');
    await db.execute('''
            CREATE TABLE ${SportTableValues.table} (
              ${SportTableValues.columnPostID} INTEGER UNSIGNED PRIMARY KEY,
              ${SportTableValues.columnFullName} TEXT NOT NULL,
              ${SportTableValues.columnProfilePicture} TEXT,
              ${SportTableValues.columnBelongToUser} INTEGER NOT NULL,
              ${SportTableValues.columnIsFavorite} INTEGER NOT NULL,
              ${SportTableValues.columnUpdateVersion} INTEGER UNSIGNED NOT NULL,
              ${SportTableValues.columnDescription} TEXT,
              ${SportTableValues.columnPublicToken} TEXT,
              ${SportTableValues.columnSportID} INTEGER UNSIGNED NOT NULL,
              ${SportTableValues.columnSportmateStatus} INTEGER UNSIGNED,
              ${SportTableValues.columnCreateDate} TEXT,
              FOREIGN KEY (${SportTableValues.columnPostID}) REFERENCES ${BasePostTableValues.table}(${BasePostTableValues.columnPostID})
              ON DELETE CASCADE
            )
        ''');
  }
  Future<void> clearDatabase() async {
    await db.delete(BasePostTableValues.table);
    await db.delete(SellBuyTableValues.table);
    await db.delete(WhisperPostTableValues.table);
    await db.delete(DatabasePhotoTableValues.table);
    await db.delete(TransportationPostTableValues.table);
    await db.delete(SportTableValues.table);
  }

  Future close() async => db.close();
}
