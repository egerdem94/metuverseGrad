import 'package:metuverse/screens/new_buy_sell/button/buysell_overflow_menu_button/controller/BuySellOverflowBackend.dart';
import 'package:metuverse/screens/whisper/button/whisper_overflow_menu_button/controller/WhisperOverflowBackend.dart';
import 'package:metuverse/screens/whisper/whisper_main/controller/storage/database/DatabaseHelperWhisper.dart';

class WhisperOverflowController {
  WhisperOverflowBackend whisperOverflowBackend = WhisperOverflowBackend();

  Future<bool> deletePressed(postID,DatabaseHelperWhisper dbHelper) async {
    bool isDeleted = await whisperOverflowBackend.deletePostRequest(postID.toString());
    if(isDeleted){
      //dbHelper.delete(postID)
      dbHelper.baseDelete(postID);
      return true;
    }
    else{
      return false;
    }
    //TODO also delete the post from local database
  }

  Future<String?> reportPostRequest(reportedPostID, reportReasonID) async {
    return await whisperOverflowBackend.reportPostRequest(reportedPostID.toString(), reportReasonID.toString());
  }
}