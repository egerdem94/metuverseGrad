import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/db/SellBuyTableValues.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/model/BuySellPost.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/controller/storage/database/TransportationPostTableValues.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/NewTransportationPost.dart';
import 'package:metuverse/screens/sport/sport_main/controller/db/SportTableValues.dart';
import 'package:metuverse/screens/sport/sport_main/model/SportPost.dart';
import 'package:metuverse/storage/database/database_helper_parent/DatabaseHelperParent.dart';
import 'package:metuverse/storage/models/BasePost.dart';

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
    else {
      throw Exception("Post type not supported");
    }
    return isSuccess;
  }

}
/*
else if(post is NewTransportationPost) {
      result = await db.transaction(
    }
 */
/*
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
  if (count == 0) {
    await baseInsertPost(postID);
  }
  return await db.transaction<int>((txn) async {
    if (count == 0) {
      debugPrint('inserted row id: $postID');
      return await txn.insert(SellBuyTableValues.table, row);
    } else {
      debugPrint('updated row id: $postID');
      return await txn.update(SellBuyTableValues.table, row,
          where: '${SellBuyTableValues.columnPostID} = ?',
          whereArgs: [postID]);
    }
  });
}*/
