import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/db/SellBuyTableValues.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/model/BuySellPost.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/controller/storage/database/TransportationPostTableValues.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/TransportationPost.dart';
import 'package:metuverse/screens/sport/sport_main/controller/db/SportTableValues.dart';
import 'package:metuverse/screens/sport/sport_main/model/SportPost.dart';
import 'package:metuverse/screens/whisper/whisper_main/controller/storage/database/WhisperPostTableValues.dart';
import 'package:metuverse/screens/whisper/whisper_main/model/WhisperPost.dart';
import 'package:metuverse/storage/database/database_helper_parent/DatabaseHelperParent.dart';
import 'package:metuverse/storage/database/database_helper_post/BasePostTableValues.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteButtonDbHelper extends DatabaseHelperParent{
  Future<bool> toggleFavorite(BasePost post) async {
    bool isSuccess;
    if (post is BuySellPost) {
      isSuccess = await db.transaction<bool>((txn) async {
        final rowsAffected = await txn.update(
          SellBuyTableValues.table,
          post.toDbMap(),
          where: '${SellBuyTableValues.columnPostID} = ?',
          whereArgs: [post.postID],
        );
        return rowsAffected > 0;
      });
    }
    else if(post is TransportationPost){
      isSuccess = await db.transaction<bool>((txn) async {
        final rowsAffected = await txn.update(
          TransportationPostTableValues.table,
          post.toDbMap(),
          where: '${TransportationPostTableValues.columnPostID} = ?',
          whereArgs: [post.postID],
        );
        return rowsAffected > 0;
      });
    }
    else if(post is SportPost){
      isSuccess = await db.transaction<bool>((txn) async {
        final rowsAffected = await txn.update(
          SportTableValues.table,
          post.toDbMap(),
          where: '${SportTableValues.columnPostID} = ?',
          whereArgs: [post.postID],
        );
        return rowsAffected > 0;
      });
    }
    else if (post is WhisperPost) {
      isSuccess = await db.transaction<bool>((txn) async {
        final rowsAffected = await txn.update(
          WhisperPostTableValues.table,
          post.toDbMap(),
          where: '${WhisperPostTableValues.columnPostID} = ?',
          whereArgs: [post.postID],
        );
        return rowsAffected > 0;
      });
    }
    else {
      throw Exception("Post type not supported");
    }
    return isSuccess;
  }
  Future<bool> isPostExistInDB(int postID) async {
    int count = await db.transaction<int>((txn) async {
      List<Map<String, dynamic>> result = await txn.query(
        BasePostTableValues.table,
        columns: ['COUNT(*) as count'],
        where: '${BasePostTableValues.columnPostID} = ?',
        whereArgs: [postID],
      );

      return Sqflite.firstIntValue(result) ?? 0;
    });
    if (count == 1) {
      return true;
    }
    else {
      return false;
    }
  }
}
