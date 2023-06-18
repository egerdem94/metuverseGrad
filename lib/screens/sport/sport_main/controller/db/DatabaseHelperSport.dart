import 'package:flutter/material.dart';
import 'package:metuverse/screens/sport/sport_main/controller/db/SportTableValues.dart';
import 'package:metuverse/screens/sport/sport_main/model/SportPost.dart';
import 'package:metuverse/storage/database/database_helper_post/DatabaseHelperPost.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperSport extends DatabaseHelperPost {
  // Helper methods
  Future<BasePostList?> getPostsFromLocalDB(
      postsToBeAskedToLocalDBAsIntList) async {
    var tempPostList =
        await queryRowsWithPostIDList(postsToBeAskedToLocalDBAsIntList);
    if (tempPostList.posts == null || tempPostList.posts!.length == 0) {
      debugPrint("Empty tempPostList while string is not empty!!!");
      return null;
    } else {
      return tempPostList;
    }
  }

  Future<int> insertOrUpdate(Map<String, dynamic> row) async {
    int postID = row['${SportTableValues.columnPostID}'];
    int count = await db.transaction<int>((txn) async {
      List<Map<String, dynamic>> result = await txn.query(
        SportTableValues.table,
        columns: ['COUNT(*) as count'],
        where: '${SportTableValues.columnPostID} = ?',
        whereArgs: [postID],
      );
      return Sqflite.firstIntValue(result)!;
      //return Future.value(Sqflite.firstIntValue(result) ?? 0);
    });
    if (count == 0) {
      await baseInsertPost(postID);
    }
    return await db.transaction<int>((txn) async {
      if (count == 0) {
        debugPrint('inserted row id: $postID');
        return await txn.insert(SportTableValues.table, row);
      } else {
        debugPrint('updated row id: $postID');
        return await txn.update(SportTableValues.table, row,
            where: '${SportTableValues.columnPostID} = ?', whereArgs: [postID]);
      }
    });
  }

  // Inserts a SportPost object to the database
  Future<int> insertSportPost(SportPost sportPost) async {
    //return await _db.insert(table, newBuySellPostX.toDbMap());
    return await insertOrUpdate(sportPost.toDbMap());
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await db.query(SportTableValues.table);
  }

  // Rows with the given postID and not equal to the given updateVersion are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<bool> isPostNeededToBeAskedBackend(
      int postID, int updateVersion) async {
    int? count = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM ${SportTableValues.table} WHERE ${SportTableValues.columnPostID} = ? AND ${SportTableValues.columnUpdateVersion} = ?',
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
    List<Map<String, dynamic>> result = await db.query(SportTableValues.table,
        where: '${SportTableValues.columnPostID} = ?', whereArgs: [postID]);
    if (result.length == 0) {
      return null;
    } else {
      return result[0];
    }
  }

  // Function gets postID list as input and calls queryRowWithPostID for each postID
  // and returns a SportPostList
  Future<SportPostList> queryRowsWithPostIDList(List<int> postIDList) async {
    SportPostList sportList = new SportPostList.defaults();
    for (int postID in postIDList) {
      Map<String, dynamic>? result = await queryRowWithPostID(postID);
      if (result != null) {
        var tempPost = SportPost.fromDbMap(result);
        sportList.addNewPost(tempPost);
      }
    }
    return sportList;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.

  Future<int> update(Map<String, dynamic> row) async {
    int id = row[SportTableValues.columnPostID];
    return await db.update(
      SportTableValues.table,
      row,
      where: '${SportTableValues.columnPostID} = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    return await db.delete(
      SportTableValues.table,
      where: '${SportTableValues.columnPostID} = ?',
      whereArgs: [id],
    );
  }
}
