import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/db/SellBuyTableValues.dart';
import 'package:metuverse/screens/whisper/whisper_main/controller/storage/database/WhisperPostTableValues.dart';
import 'package:metuverse/screens/whisper/whisper_main/model/WhisperPost.dart';
import 'package:metuverse/storage/database/database_helper_post/BasePostTableValues.dart';
import 'package:metuverse/storage/database/database_helper_post/DatabaseHelperPost.dart';
import 'package:metuverse/storage/database/database_photo/DatabasePhotoTableValues.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperWhisper extends DatabaseHelperPost {
  Future<BasePostList?> getPostsFromLocalDB(
      postsToBeAskedToLocalDBAsIntList) async {
    var tempPostList =
        await queryRowsWithPostIDList(postsToBeAskedToLocalDBAsIntList);
    if (tempPostList.posts == null ||
        tempPostList.posts!.length == 0) {
      debugPrint("Empty tempPostList while string is not empty!!!");
      return null;
    } else {
      return tempPostList;
    }
  }

  // Helper methods

  Future<int> insertOrUpdate(Map<String, dynamic> row) async {
    int postID = row['${WhisperPostTableValues.columnPostID}'];
    int count = await db.transaction<int>((txn) async {
      List<Map<String, dynamic>> result = await txn.query(
        WhisperPostTableValues.table,
        columns: ['COUNT(*) as count'],
        where: '${WhisperPostTableValues.columnPostID} = ?',
        whereArgs: [postID],
      );

      return Sqflite.firstIntValue(result) ?? 0;
    });
    if (count == 0) {
      await baseInsertPost(postID);
    }
    return await db.transaction<int>((txn) async {
      if (count == 0) {
        debugPrint('inserted row id: $postID');
        return await txn.insert(WhisperPostTableValues.table, row);
      } else {
        debugPrint('updated row id: $postID');
/*        await txn.delete(BasePostTableValues.table,
            where: '${BasePostTableValues.columnPostID} = ?',
            whereArgs: [postID]);
        return await txn.insert(WhisperPostTableValues.table, row);*/
        await txn.delete(DatabasePhotoTableValues.table,
            where: '${DatabasePhotoTableValues.columnPostID} = ?',
            whereArgs: [postID]);
        return await txn.update(WhisperPostTableValues.table, row,
            where: '${WhisperPostTableValues.columnPostID} = ?',
            whereArgs: [postID]);
      }
    });
  }

  // Inserts a BuySellPost object to the database
  Future<int> insertBuySellPost(WhisperPost whisperPost) async {
    //return await _db.insert(table, newBuySellPostX.toDbMap());
    return await insertOrUpdate(whisperPost.toDbMap());
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await db.query(WhisperPostTableValues.table);
  }

  // Rows with the given postID and not equal to the given updateVersion are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<bool> isPostNeededToBeAskedBackend(
      int postID, int updateVersion) async {
    int? count = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM ${WhisperPostTableValues.table} WHERE ${WhisperPostTableValues.columnPostID} = ? AND ${WhisperPostTableValues.columnUpdateVersion} = ?',
        [postID, updateVersion]));
    if (count == 1) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<List<int>>> getNeededPostIdList(
      PostsToDisplay? postsToDisplay) async {
    List<int> postIDsToBeAskedBackend = [];
    List<int> postIDsExistInLocalDB = [];
    if (postsToDisplay == null) {
      return [postIDsToBeAskedBackend, postIDsExistInLocalDB];
    }
    for (var postToDisplay in postsToDisplay.postsToDisplayList!) {
      if (await isPostNeededToBeAskedBackend(
          postToDisplay.postID!, postToDisplay.updateVersion!)) {
        postIDsToBeAskedBackend.add(postToDisplay.postID!);
      } else {
        postIDsExistInLocalDB.add(postToDisplay.postID!);
      }
    }
    return [postIDsToBeAskedBackend, postIDsExistInLocalDB];
  }

  // Rows with the given postID are returned as a list of maps, where each map is
  // a key-value list of columns.
  // if postID not found, returns null
  Future<Map<String, dynamic>?> queryRowWithPostID(int postID) async {
    List<Map<String, dynamic>> result = await db.query(WhisperPostTableValues.table,
        where: '${WhisperPostTableValues.columnPostID} = ?', whereArgs: [postID]);
    if (result.length == 0) {
      return null;
    } else {
      return result[0];
    }
  }

  // Function gets postID list as input and calls queryRowWithPostID for each postID
  // and returns a list of NewBuySellPostX objects
  Future<WhisperPostList> queryRowsWithPostIDList(List<int> postIDList) async {
    //List<NewBuySellPostX> newBuySellPostXList = [];
    WhisperPostList whisperPostList = new WhisperPostList.defaults();
    for (int postID in postIDList) {
      Map<String, dynamic>? result = await queryRowWithPostID(postID);
      if (result != null) {
        var tempPost = WhisperPost.fromDbMap(result);
        whisperPostList.addNewPost(tempPost);
      }
    }
    return whisperPostList;
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  /*
  Future<int> queryRowCount() async {
    final results = await db.rawQuery('SELECT COUNT(*) FROM ${WhisperPostTableValues.table}');
    return Sqflite.firstIntValue(results) ?? 0;
  }
  */

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.

  Future<int> update(Map<String, dynamic> row) async {
    int id = row[WhisperPostTableValues.columnPostID];
    return await db.update(
      WhisperPostTableValues.table,
      row,
      where: '${WhisperPostTableValues.columnPostID} = ?',
      whereArgs: [id],
    );
  }

  /*// Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    return await db.delete(
      WhisperPostTableValues.table,
      where: '${WhisperPostTableValues.columnPostID} = ?',
      whereArgs: [id],
    );
  }*/
}
