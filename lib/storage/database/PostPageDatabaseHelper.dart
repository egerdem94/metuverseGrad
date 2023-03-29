import 'package:flutter/foundation.dart';
import 'package:metuverse/storage/database/DatabaseHelper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PostPageDatabaseHelper extends DatabaseHelper{
  static const table = 'posts';

  static const columnPostID = '_postID';

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
  Future baseInsertPost(int postID) async{
    int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table WHERE $columnPostID = ?', [postID]));
    if (count == 0) {
      debugPrint('inserted to base table with row id: $postID');
      final row = {
        //columnPhotoID: 2,
        columnPostID: postID,
      };
      await db.insert(table, row);
    }
  }
  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> baseDelete(int id) async {
    return await db.delete(
      table,
      where: '$columnPostID = ?',
      whereArgs: [id],
    );
  }

}