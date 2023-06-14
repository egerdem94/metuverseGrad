import 'package:metuverse/screens/new_buy_sell/button/buysell_overflow_menu_button/controller/BuySellOverflowBackend.dart';

class TransportationOverflowController{
  BuySellOverflowBackend commercialOverflowBackend = BuySellOverflowBackend();

  Future<bool> deletePressed(postID) async{
    return await commercialOverflowBackend.deletePostRequest(postID.toString());
    //TODO also delete the post from local database
  }
  Future<bool> selectAsFoundPressed(postID) async{
    return true;
    //return await commercialOverflowBackend.selectAsFoundRequest(postID.toString());
  }
}