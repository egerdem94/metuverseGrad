import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:metuverse/storage/database/database_helper_parent/DatabaseHelperParent.dart';
import 'package:metuverse/storage/database/database_photo/DatabasePhotoTableValues.dart';
import 'package:metuverse/storage/models/Photo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class DatabaseHelperPhoto extends DatabaseHelperParent{


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
      CREATE TABLE IF NOT EXISTS ${DatabasePhotoTableValues.table} (
        ${DatabasePhotoTableValues.columnPhotoID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabasePhotoTableValues.columnPostID} INTEGER UNSIGNED,
        ${DatabasePhotoTableValues.columnPhotoSource} TEXT,
        ${DatabasePhotoTableValues.columnPhotoData} BLOB,
        ${DatabasePhotoTableValues.columnInsertionDate} DATE,
        FOREIGN KEY (${DatabasePhotoTableValues.columnPostID}) REFERENCES ${DatabasePhotoTableValues.otherTable}(${DatabasePhotoTableValues.columnOtherTablePostID})
        ON DELETE CASCADE
      )
      '''
    );
  }

  Future<bool> doesPhotoExist(int postID, String url) async {
    int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM ${DatabasePhotoTableValues.table} WHERE ${DatabasePhotoTableValues.columnPostID} = ? AND ${DatabasePhotoTableValues.columnPhotoSource} = ?', [postID, url]));

    return (count > 0) ? true : false;

  }

  Future<Photo?> insertPhotoFromUrl(int postID,String url) async {
    if(await doesPhotoExist(postID, url)) {
      debugPrint("Photo already exist!");
      return null;
    }
    //final response = await http.get(Uri.parse("https://upload.wikimedia.org/wikipedia/en/thumb/9/94/Old_part_of_calne.size-_100_KB.jpg/1200px-Old_part_of_calne.size-_100_KB.jpg?20090310223710"));
    final response = await http.get(Uri.parse(url));
    final photoData = response.bodyBytes;
    final row = {
      //columnPhotoID: 2,
      DatabasePhotoTableValues.columnPostID: postID,
      DatabasePhotoTableValues.columnPhotoSource: url,
      DatabasePhotoTableValues.columnPhotoData: photoData,
      DatabasePhotoTableValues.columnInsertionDate: DateTime.now().toIso8601String(),
    };
    //return await db.insert('$table', {'$columnPostID':postID,'$columnPhotoData': photoData});
    var x = await db.insert(DatabasePhotoTableValues.table, row); //Can be checked
    return Photo(0,postID,url,photoData);
  }
/*  Future insertPseudoList(List<PseudoPhoto> pseudoPhotos) async {
    for(var pseudo in pseudoPhotos){
      await insertPhotoFromUrl(pseudo.postID,pseudo.photoUrl);
    }
  }
  Future insertPseudoLists(List<List<PseudoPhoto>> pseudoPhotosList) async{
    for(var pseudos in pseudoPhotosList){
      await insertPseudoList(pseudos);
    }
  }*/

  Future insertNewPhoto(Photo photo) async{
    final row = {
      //columnPhotoID: 2,
      DatabasePhotoTableValues.columnPostID: photo.postID,
      DatabasePhotoTableValues.columnPhotoSource: photo.photoUrl,
      DatabasePhotoTableValues.columnPhotoData: photo.photoData,
      DatabasePhotoTableValues.columnInsertionDate: DateTime.now().toIso8601String(),
    };
    //return await db.insert('$table', {'$columnPostID':postID,'$columnPhotoData': photoData});
    return await db.insert(DatabasePhotoTableValues.table, row);
  }

  Future insertNewPhotos(PhotoList photoList) async{
    for(var photo in photoList.photos) {
      if(photo.shouldBeInsertedToDB)
        await insertNewPhoto(photo);
    }
  }

  Future<Photo?> getPhotoGivenPostIDAndUrl(int postID, String Url) async{
    final photosData = await db.query(DatabasePhotoTableValues.table,
        where: '${DatabasePhotoTableValues.columnPostID} = ? AND ${DatabasePhotoTableValues.columnPhotoSource} = ?',
        whereArgs: [postID, Url]);

    return (photosData.length != 0) ? Photo.fromDbMap(photosData[0]) : null;
  }

  Future<PhotoList> getPhotosGivenPostIDs(List<int> postIDs) async{
    PhotoList photoList = PhotoList();
    for(var id in postIDs){
      final photosData = await db.query(DatabasePhotoTableValues.table,
        where: '${DatabasePhotoTableValues.columnPostID} = ?',
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
    final photosData = await db.query(DatabasePhotoTableValues.table,
        where: '${DatabasePhotoTableValues.columnPostID} = ?',
        whereArgs: [postID]);
    if(photosData.length == 0)
      return [];
    else
      return photosData.map((photoData) {
        final bytes = photoData['${DatabasePhotoTableValues.columnPhotoData}'] as Uint8List;
        debugPrint("Photo ID:" + photoData['${DatabasePhotoTableValues.columnPhotoID}'].toString());
        debugPrint("Insertion Date:" + photoData['${DatabasePhotoTableValues.columnInsertionDate}'].toString());
        return bytes;
      }).toList();
  }

  //debug purpose
  Future<List<Uint8List>> getAllPhotosInDB() async {
    final photosData = await db.query('${DatabasePhotoTableValues.table}');

    return photosData.map((photoData) {
      final bytes = photoData['${DatabasePhotoTableValues.columnPhotoData}'] as Uint8List;
      return bytes;
    }).toList();
  }
}
