import 'package:flutter/material.dart';
import 'package:metuverse/new_buy_sell/controllers/storage/database/SellBuyTableValues.dart';
import 'package:metuverse/storage/database/database_helper_parent/DatabaseHelperParent.dart';
import 'package:metuverse/storage/database/database_helper_post/DatabaseHelperPost.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/new_buy_sell/models/BuySellPost.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelperSellBuy extends DatabaseHelperPost{

  Future<BasePostList?> getPostsFromLocalDB(postsToBeAskedToLocalDBAsIntList) async {
    var tempNewBuySellPostListX = await queryRowsWithPostIDList(postsToBeAskedToLocalDBAsIntList);
    if(tempNewBuySellPostListX.newBuySellPostListX == null || tempNewBuySellPostListX.newBuySellPostListX!.length == 0){
      debugPrint("Empty tempNewBuySellPostListX while string is not empty!!!");
      return null;
    }
    else{
      return tempNewBuySellPostListX;
    }
  }

  // Helper methods

  Future<int> insertOrUpdate(Map<String, dynamic> row) async {
    int postID = row['${SellBuyTableValues.columnPostID}'];
    int count = await db.transaction<int>((txn) async {
      List<Map<String, dynamic>> result = await txn.query(
        SellBuyTableValues.table,
        columns: ['COUNT(*) as count'],
        where: '${SellBuyTableValues.columnPostID} = ?',
        whereArgs: [postID],
      );

      return Sqflite.firstIntValue(result);
    });
    if(count == 0) {
      await baseInsertPost(postID);
    }
    return await db.transaction<int>((txn) async {
      if (count == 0) {
        debugPrint('inserted row id: $postID');
        return await txn.insert(SellBuyTableValues.table, row);
      } else {
        debugPrint('updated row id: $postID');
        return await txn.update(SellBuyTableValues.table, row, where: '${SellBuyTableValues.columnPostID} = ?', whereArgs: [postID]);
      }
  });
  }

  // Inserts a NewBuySellPostX object to the database
  Future<int> insertNewBuySellPostX(BuySellPost newBuySellPostX) async {
    //return await _db.insert(table, newBuySellPostX.toDbMap());
    return await insertOrUpdate(newBuySellPostX.toDbMap());

  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await db.query(SellBuyTableValues.table);
  }


  // Rows with the given postID and not equal to the given updateVersion are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<bool> isPostNeededToBeAskedBackend(
      int postID, int updateVersion) async {
    int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM ${SellBuyTableValues.table} WHERE ${SellBuyTableValues.columnPostID} = ? AND ${SellBuyTableValues.columnUpdateVersion} = ?', [postID,updateVersion]));
    if(count == 1){
      return false;
    }
    else{
      return true;
    }
  }

  Future<List<List<int>>> getNeededPostIdList(PostsToDisplay? postsToDisplay) async {
    List<int> postIDsToBeAskedBackend = [];
    List<int> postIDsExistInLocalDB = [];
    if(postsToDisplay == null){
      return [postIDsToBeAskedBackend, postIDsExistInLocalDB];
    }
    for(var postToDisplay in postsToDisplay.postsToDisplayList!){
      if(await isPostNeededToBeAskedBackend(postToDisplay.postID!, postToDisplay.updateVersion!)){
        postIDsToBeAskedBackend.add(postToDisplay.postID!);
      }
      else{
        postIDsExistInLocalDB.add(postToDisplay.postID!);
      }
    }
    return [postIDsToBeAskedBackend, postIDsExistInLocalDB];
  }



  // Rows with the given postID are returned as a list of maps, where each map is
  // a key-value list of columns.
  // if postID not found, returns null
  Future<Map<String, dynamic>?> queryRowWithPostID(int postID) async {
    List<Map<String, dynamic>> result = await db.query(SellBuyTableValues.table,
        where: '${SellBuyTableValues.columnPostID} = ?',
        whereArgs: [postID]);
    if (result.length == 0) {
      return null;
    } else {
      return result[0];
    }
  }
  // Function gets postID list as input and calls queryRowWithPostID for each postID
  // and returns a list of NewBuySellPostX objects
  Future<BuySellPostList> queryRowsWithPostIDList(List<int> postIDList) async {
    //List<NewBuySellPostX> newBuySellPostXList = [];
    BuySellPostList newBuySellPostListX = new BuySellPostList.defaults();
    for (int postID in postIDList) {
      Map<String, dynamic>? result = await queryRowWithPostID(postID);
      if (result != null) {
        var tempPost = BuySellPost.fromDbMap(result);
        newBuySellPostListX.addNewPost(tempPost);
      }
    }
    return newBuySellPostListX;
  }


  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  /*
  Future<int> queryRowCount() async {
    final results = await db.rawQuery('SELECT COUNT(*) FROM ${SellBuyTableValues.table}');
    return Sqflite.firstIntValue(results) ?? 0;
  }
  */

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.

  Future<int> update(Map<String, dynamic> row) async {
    int id = row[SellBuyTableValues.columnPostID];
    return await db.update(
      SellBuyTableValues.table,
      row,
      where: '${SellBuyTableValues.columnPostID} = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    return await db.delete(
      SellBuyTableValues.table,
      where: '${SellBuyTableValues.columnPostID} = ?',
      whereArgs: [id],
    );
  }

}