import 'package:flutter/foundation.dart';
import 'package:metuverse/storage/database/database_helper_parent/DatabaseHelperParent.dart';
import 'package:metuverse/storage/database/database_helper_post/BasePostTableValues.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperPost extends DatabaseHelperParent {
/*  // this opens the database (and creates it if it doesn't exist)
  Future<void> baseInit() async {
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
          CREATE TABLE $PostPageDatabaseHelper.table (
            $PostPageDatabaseHelper.columnPostID INTEGER UNSIGNED PRIMARY KEY,
          )
          ''');
  }*/
  Future baseInsertPost(int postID) async {
    //following code in the style
    //int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM ${BasePostTableValues.table} WHERE ${BasePostTableValues.columnPostID} = ?', [postID]));
    /*    if (count == 0) {
      debugPrint('inserted to base table with row id: $postID');
      final row = {
        //columnPhotoID: 2,
        BasePostTableValues.columnPostID: postID,
      };
      await db.insert(BasePostTableValues.table, row);
    }*/
    return await db.transaction<int>((txn) async {
      List<Map<String, dynamic>> result = await txn.query(
        BasePostTableValues.table,
        columns: ['COUNT(*) as count'],
        where: '${BasePostTableValues.columnPostID} = ?',
        whereArgs: [postID],
      );

      int? count = Sqflite.firstIntValue(result);

      if (count == 0) {
        debugPrint('inserted to base table with row id: $postID');
        final row = {
          //columnPhotoID: 2,
          BasePostTableValues.columnPostID: postID,
        };
        return await txn.insert(BasePostTableValues.table, row);
      } else {
        debugPrint(
            'postID $postID already exists in base the table $BasePostTableValues.table ');
        return 0;
      }
    });
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> baseDelete(int id) async {
    return await db.delete(
      BasePostTableValues.table,
      where: '${BasePostTableValues.columnPostID} = ?',
      whereArgs: [id],
    );
  }
}
