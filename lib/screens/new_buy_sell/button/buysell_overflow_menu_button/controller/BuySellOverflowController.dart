import 'package:metuverse/screens/new_buy_sell/button/buysell_overflow_menu_button/controller/BuySellOverflowBackend.dart';

class BuySellOverflowController{
  BuySellOverflowBackend buySellOverflowBackend = BuySellOverflowBackend();

  Future<bool> deletePressed(postID) async{
    return await buySellOverflowBackend.deletePostRequest(postID.toString());
    //TODO also delete the post from local database
  }
  Future<bool> selectAsFoundPressed(postID) async{
    return await buySellOverflowBackend.selectAsFoundRequest(postID.toString());
  }
}