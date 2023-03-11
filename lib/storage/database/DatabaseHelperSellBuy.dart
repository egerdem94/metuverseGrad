import 'package:flutter/material.dart';
import 'package:metuverse/storage/database/DatabaseHelper.dart';
import 'package:metuverse/storage/models/IPostList.dart';
import 'package:metuverse/storage/models/NewBuySellPostListX.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelperSellBuy extends DatabaseHelper{
  //static const _databaseName = "MyDatabase.db";
  //static const _databaseVersion = 1;

  static const table = 'buy_sell_posts';

  static const columnPostID = '_postID';
  static const columnFullName = 'fullName';
  static const columnProfilePicture = 'profilePicture';
  static const columnBelongToUser = 'belongToUser';
  static const columnUpdateVersion = 'updateVersion';
  static const columnMedia = 'media';
  static const columnDescription = 'description';
  static const columnProductPrice = 'productPrice';
  static const columnCurrency = 'currency';
  static const columnProductStatus = 'productStatus';

  //late Database db;

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
    await db.execute('''
          CREATE TABLE $table (
            $columnPostID INTEGER UNSIGNED PRIMARY KEY,
            $columnFullName TEXT NOT NULL,
            $columnProfilePicture TEXT,
            $columnBelongToUser INTEGER NOT NULL,
            $columnUpdateVersion INTEGER UNSIGNED NOT NULL,
            $columnMedia TEXT,
            $columnDescription TEXT,
            $columnProductPrice INTEGER UNSIGNED,
            $columnCurrency TEXT,
            $columnProductStatus INTEGER UNSIGNED NOT NULL
          )
          ''');
  }
  Future<IPostList?> getPostsFromLocalDB(postsToBeAskedToLocalDBAsIntList) async {
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

    int postID = row['$columnPostID'];
    int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table WHERE $columnPostID = ?', [postID]));
    if (count == 0) {
      debugPrint('inserted row id: $postID');
      return await db.insert(table, row);
    } else {
      debugPrint('updated row id: $postID');
      return await db.update(table, row, where: '$columnPostID = ?', whereArgs: [postID]);
    }
  }

  // Inserts a NewBuySellPostX object to the database
  Future<int> insertNewBuySellPostX(NewBuySellPostX newBuySellPostX) async {
    //return await _db.insert(table, newBuySellPostX.toDbMap());
    return await insertOrUpdate(newBuySellPostX.toDbMap());

  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await db.query(table);
  }

/*  // Rows with the given postID and not equal to the given updateVersion are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<bool> isPostNeededToBeAskedBackend(
      int postID, int updateVersion) async {
    var returnedTable = await _db.query(table,
        where: '$columnPostID = ? AND $columnUpdateVersion != ?',
        whereArgs: [postID, updateVersion]);
    if(returnedTable.length == 0){
      return true;
    }
    return false;
  }*/

  // Rows with the given postID and not equal to the given updateVersion are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<bool> isPostNeededToBeAskedBackend(
      int postID, int updateVersion) async {
    int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table WHERE $columnPostID = ? AND $columnUpdateVersion = ?', [postID,updateVersion]));
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
    for(var postToDisplay in postsToDisplay!.postsToDisplayList!){
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
    List<Map<String, dynamic>> result = await db.query(table,
        where: '$columnPostID = ?',
        whereArgs: [postID]);
    if (result.length == 0) {
      return null;
    } else {
      return result[0];
    }
  }
  // Function gets postID list as input and calls queryRowWithPostID for each postID
  // and returns a list of NewBuySellPostX objects
  Future<NewBuySellPostListX> queryRowsWithPostIDList(List<int> postIDList) async {
    //List<NewBuySellPostX> newBuySellPostXList = [];
    NewBuySellPostListX newBuySellPostListX = new NewBuySellPostListX.defaults();
    for (int postID in postIDList) {
      Map<String, dynamic>? result = await queryRowWithPostID(postID);
      if (result != null) {
        var tempPost = NewBuySellPostX.fromDbMap(result);
        newBuySellPostListX.addNewPost(tempPost);
      }
    }
    return newBuySellPostListX;
  }


  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    final results = await db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    int id = row[columnPostID];
    return await db.update(
      table,
      row,
      where: '$columnPostID = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    return await db.delete(
      table,
      where: '$columnPostID = ?',
      whereArgs: [id],
    );
  }

}