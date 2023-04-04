import 'package:flutter/material.dart';
import 'package:metuverse/new_buy_sell/controllers/storage/database/SellBuyTableValues.dart';
import 'package:metuverse/new_transportation/controller/storage/database/TransportationPostTableValues.dart';
import 'package:metuverse/new_transportation/model/NewTransportationPost.dart';
import 'package:metuverse/storage/database/database_helper_parent/DatabaseHelperParent.dart';
import 'package:metuverse/storage/database/database_helper_post/DatabaseHelperPost.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/new_buy_sell/models/BuySellPost.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelperTransportation extends DatabaseHelperPost{

  Future<BasePostList?> getPostsFromLocalDB(postsToBeAskedToLocalDBAsIntList) async {
    var tempNewTransportationPostList = await queryRowsWithPostIDList(postsToBeAskedToLocalDBAsIntList);
    if(tempNewTransportationPostList.posts == null || tempNewTransportationPostList.posts!.length == 0){
      debugPrint("Empty tempNewBuySellPostListX while string is not empty!!!");
      return null;
    }
    else{
      return tempNewTransportationPostList;
    }
  }

  // Helper methods

  Future<int> insertOrUpdate(Map<String, dynamic> row) async {
    int postID = row['${TransportationPostTableValues.columnPostID}'];
    int count = await db.transaction<int>((txn) async {
      List<Map<String, dynamic>> result = await txn.query(
        TransportationPostTableValues.table,
        columns: ['COUNT(*) as count'],
        where: '${TransportationPostTableValues.columnPostID} = ?',
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
        return await txn.insert(TransportationPostTableValues.table, row);
      } else {
        debugPrint('updated row id: $postID');
        return await txn.update(TransportationPostTableValues.table, row, where: '${TransportationPostTableValues.columnPostID} = ?', whereArgs: [postID]);
      }
    });
  }

  // Inserts a NewBuySellPostX object to the database
  Future<int> insertNewTransportationPost(NewTransportationPost newTransportationPost) async {
    return await insertOrUpdate(newTransportationPost.toDbMap());

  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await db.query(TransportationPostTableValues.table);
  }


  // Rows with the given postID and not equal to the given updateVersion are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<bool> isPostNeededToBeAskedBackend(
      int postID, int updateVersion) async {
    int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM ${TransportationPostTableValues.table} WHERE ${TransportationPostTableValues.columnPostID} = ? AND ${TransportationPostTableValues.columnUpdateVersion} = ?', [postID,updateVersion]));
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
    List<Map<String, dynamic>> result = await db.query(TransportationPostTableValues.table,
        where: '${TransportationPostTableValues.columnPostID} = ?',
        whereArgs: [postID]);
    if (result.length == 0) {
      return null;
    } else {
      return result[0];
    }
  }
  // Function gets postID list as input and calls queryRowWithPostID for each postID
  // and returns a list of NewBuySellPostX objects
  Future<NewTransportationPostList> queryRowsWithPostIDList(List<int> postIDList) async {
    NewTransportationPostList newTransportationPostList = NewTransportationPostList.defaults();
    for (int postID in postIDList) {
      Map<String, dynamic>? result = await queryRowWithPostID(postID);
      if (result != null) {
        var tempPost = NewTransportationPost.fromDbMap(result);
        newTransportationPostList.addNewPost(tempPost);
      }
    }
    return newTransportationPostList;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  //TODO Bu "update" neye yarıyor???
  Future<int> update(Map<String, dynamic> row) async {
    int id = row[TransportationPostTableValues.columnPostID];
    return await db.update(
      TransportationPostTableValues.table,
      row,
      where: '${TransportationPostTableValues.columnPostID} = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    return await db.delete(
      TransportationPostTableValues.table,
      where: '${TransportationPostTableValues.columnPostID} = ?',
      whereArgs: [id],
    );
  }

}