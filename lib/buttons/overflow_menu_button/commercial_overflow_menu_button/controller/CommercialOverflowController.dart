import 'package:metuverse/buttons/overflow_menu_button/commercial_overflow_menu_button/controller/CommercialOverflowBackend.dart';

class CommercialOverflowController{
  CommercialOverflowBackend commercialOverflowBackend = CommercialOverflowBackend();

  Future<bool> deletePressed(postID) async{
    return await commercialOverflowBackend.deletePostRequest(postID.toString());
    //TODO also delete the post from local database
  }
}