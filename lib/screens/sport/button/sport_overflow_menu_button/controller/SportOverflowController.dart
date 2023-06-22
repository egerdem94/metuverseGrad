import 'package:metuverse/screens/sport/button/sport_overflow_menu_button/controller/SportOverflowBackend.dart';
import 'package:metuverse/screens/sport/sport_main/controller/db/DatabaseHelperSport.dart';

class SportOverflowController {
  SportOverflowBackend sportOverflowBackend = SportOverflowBackend();

  Future<bool> deletePressed(postID,DatabaseHelperSport dbHelper) async {
    bool isDeleted = await sportOverflowBackend.deletePostRequest(postID.toString());
    if(isDeleted){
      dbHelper.baseDelete(postID);
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool> selectAsFoundPressed(postID) async {
    return await sportOverflowBackend.selectAsFoundRequest(postID.toString());
  }

  Future<String?> reportPostRequest(reportedPostID, reportReasonID) async {
    return await sportOverflowBackend.reportPostRequest(reportedPostID.toString(), reportReasonID.toString());
  }
}