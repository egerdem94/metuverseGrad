import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:metuverse/storage/database/DatabaseHelper.dart';
import 'package:metuverse/storage/models/Photo.dart';
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
  static const columnPhotoSource = 'photoSource';
  static const columnPhotoData = 'photoData';
  static const columnInsertionDate = 'insertionDate';
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
        $columnPhotoSource TEXT,
        $columnPhotoData BLOB,
        $columnInsertionDate DATE,
        FOREIGN KEY ($columnPostID) REFERENCES $otherTable($columnOtherTablePostID)
        ON DELETE CASCADE
      )
      '''
    );
  }
  Future<int> insertPhotoFromUrl(postID,String url) async {
    final response = await http.get(Uri.parse("https://upload.wikimedia.org/wikipedia/en/thumb/9/94/Old_part_of_calne.size-_100_KB.jpg/1200px-Old_part_of_calne.size-_100_KB.jpg?20090310223710"));
    //final response = await http.get(Uri.parse(url));
    final photoData = response.bodyBytes;
    final row = {
      //columnPhotoID: 2,
      columnPostID: postID,
      columnPhotoSource: url,
      columnPhotoData: photoData,
      columnInsertionDate: DateTime.now().toIso8601String(),
    };
    //return await db.insert('$table', {'$columnPostID':postID,'$columnPhotoData': photoData});
    return await db.insert(table, row);
  }
  Future insertPseudoList(List<PseudoPhoto> pseudoPhotos) async {
    for(var pseudo in pseudoPhotos){
      await insertPhotoFromUrl(pseudo.postID,pseudo.photoUrl);
    }
  }
  Future insertPseudoLists(List<List<PseudoPhoto>> pseudoPhotosList) async{
    for(var pseudos in pseudoPhotosList){
      await insertPseudoList(pseudos);
    }
  }
  Future<PhotoList> getPhotosGivenPostIDs(List<int> postIDs) async{
    PhotoList photoList = PhotoList();
    for(var id in postIDs){
      final photosData = await db.query(table,
        where: '$columnPostID = ?',
        whereArgs: [id]);
      if(photosData.length != 0){
        for(var photoRow in photosData){
          photoList.addPhoto(Photo.fromDbMap(photoRow));
        }
      }
    }
    return photoList;
  }
  Future<List<Uint8List>> getAllPhotosWithPostID(postID) async {
    final photosData = await db.query(table,
        where: '$columnPostID = ?',
        whereArgs: [postID]);
    if(photosData.length == 0)
      return [];
    else
      return photosData.map((photoData) {
        final bytes = photoData['$columnPhotoData'] as Uint8List;
        debugPrint("Photo ID:" + photoData['$columnPhotoID'].toString());
        debugPrint("Insertion Date:" + photoData['$columnInsertionDate'].toString());
        return bytes;
      }).toList();
  }

  //debug purpose
  Future<List<Uint8List>> getAllPhotosInDB() async {
    final photosData = await db.query('$table');

    return photosData.map((photoData) {
      final bytes = photoData['$columnPhotoData'] as Uint8List;
      return bytes;
    }).toList();
  }
}
