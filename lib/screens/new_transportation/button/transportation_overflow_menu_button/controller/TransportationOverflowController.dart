import 'package:metuverse/screens/new_transportation/button/transportation_overflow_menu_button/controller/TransportationOverflowBackend.dart';

class TransportationOverflowController{
  TransportationOverflowBackend commercialOverflowBackend = TransportationOverflowBackend();

  Future<bool> deletePressed(postID) async{
    return await commercialOverflowBackend.deletePostRequest(postID.toString());
    //TODO also delete the post from local database
  }
  Future<bool> selectAsFoundPressed(postID) async{
    return await commercialOverflowBackend.selectAsFoundRequest(postID.toString());
  }
}