import 'package:metuverse/screens/whisper/button/whisper_overflow_menu_button/controller/WhisperOverflowBackend.dart';
import 'package:metuverse/screens/whisper/whisper_main/controller/storage/database/DatabaseHelperWhisper.dart';

class WhisperOverflowController {
  WhisperOverflowBackend whisperOverflowBackend = WhisperOverflowBackend();

  Future<bool> deletePressed(postID,DatabaseHelperWhisper dbHelper) async {
    bool isDeleted = await whisperOverflowBackend.deletePostRequest(postID.toString());
    if(isDeleted){
      dbHelper.baseDelete(postID);
      return true;
    }
    else{
      return false;
    }
  }

  Future<String?> reportPostRequest(reportedPostID, reportReasonID) async {
    return await whisperOverflowBackend.reportPostRequest(reportedPostID.toString(), reportReasonID.toString());
  }
}