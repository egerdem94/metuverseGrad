import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:metuverse/storage/database/database_helper_parent/DatabaseHelperParent.dart';
import 'package:metuverse/storage/database/database_helper_post/BasePostTableValues.dart';
import 'package:metuverse/storage/database/database_photo/DatabasePhotoTableValues.dart';
import 'package:metuverse/storage/models/Photo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class DatabaseHelperPhoto extends DatabaseHelperParent{
  /// check if photo exists in database
  Future<bool> doesPhotoExist(int postID, String url) async {
    return await db.transaction<bool>((txn) async {
      int count = Sqflite.firstIntValue(await txn.rawQuery('SELECT COUNT(*) FROM ${DatabasePhotoTableValues.table} WHERE ${DatabasePhotoTableValues.columnPostID} = ? AND ${DatabasePhotoTableValues.columnPhotoSource} = ?', [postID, url]));

      return (count > 0) ? true : false;
    });
  }
  ///Inserts photo from url to database, also returns the photo object
  Future<Photo?> insertPhotoFromUrl(int postID,String url) async {
    if(await doesPhotoExist(postID, url)) {
      debugPrint("Photo already exist!");
      return null;
    }
    final response = await http.get(Uri.parse(url));
    final photoData = response.bodyBytes;
    final row = {
      DatabasePhotoTableValues.columnPostID: postID,
      DatabasePhotoTableValues.columnPhotoSource: url,
      DatabasePhotoTableValues.columnPhotoData: photoData,
      DatabasePhotoTableValues.columnInsertionDate: DateTime.now().toIso8601String(),
    };
    //return await db.insert('$table', {'$columnPostID':postID,'$columnPhotoData': photoData});
    await db.transaction((txn) async {
      await txn.insert(DatabasePhotoTableValues.table, row); //Can be checked
    });
    return Photo(0,postID,url,photoData);
  }
  Future<Photo?> getPhotoGivenPostIDAndUrl(int postID, String url) async{
    return await db.transaction<Photo?>((txn) async {
      final photosData = await txn.query(DatabasePhotoTableValues.table,
          where: '${DatabasePhotoTableValues.columnPostID} = ? AND ${DatabasePhotoTableValues.columnPhotoSource} = ?',
          whereArgs: [postID, url]);

      return (photosData.length != 0) ? Photo.fromDbMap(photosData[0]) : null;
    });
  }
//get photoUrls given postID
  Future<List<String>?> getPhotoUrlsGivenPostID(int postID) async {
    return await db.transaction<List<String>>((txn) async {
      final photosData = await txn.query(
        DatabasePhotoTableValues.table,
        columns: [DatabasePhotoTableValues.columnPhotoSource],
        where: '${DatabasePhotoTableValues.columnPostID} = ?',
        whereArgs: [postID],
      );

      List<String>? photoUrls = photosData
          .map((photoData) => photoData[DatabasePhotoTableValues.columnPhotoSource]).cast<String>()
          .toList();

      return photoUrls;
    });
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

/*  Future insertNewPhoto(Photo photo) async{
    return await db.transaction<int>((txn) async {
      final row = {
        DatabasePhotoTableValues.columnPostID: photo.postID,
        DatabasePhotoTableValues.columnPhotoSource: photo.photoUrl,
        DatabasePhotoTableValues.columnPhotoData: photo.photoData,
        DatabasePhotoTableValues.columnInsertionDate: DateTime.now().toIso8601String(),
      };
      return await db.insert(DatabasePhotoTableValues.table, row);
    });
*//*    final row = {
      DatabasePhotoTableValues.columnPostID: photo.postID,
      DatabasePhotoTableValues.columnPhotoSource: photo.photoUrl,
      DatabasePhotoTableValues.columnPhotoData: photo.photoData,
      DatabasePhotoTableValues.columnInsertionDate: DateTime.now().toIso8601String(),
    };
    return await db.insert(DatabasePhotoTableValues.table, row);*//*
  }*/
/*
  Future insertNewPhotos(PhotoList photoList) async{
    for(var photo in photoList.photos) {
      if(photo.shouldBeInsertedToDB)
        await insertNewPhoto(photo);
    }
  }*/
/*
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
  }*/
/*  Future<List<Uint8List>> getAllPhotosWithPostID(postID) async {
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
  }*/
/*
  //debug purpose
  Future<List<Uint8List>> getAllPhotosInDB() async {
    final photosData = await db.query('${DatabasePhotoTableValues.table}');

    return photosData.map((photoData) {
      final bytes = photoData['${DatabasePhotoTableValues.columnPhotoData}'] as Uint8List;
      return bytes;
    }).toList();
  }*/
}
