import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';

class PostHandler{
  List<int> convertIdList(postIDListAsString) {
    List<int> convertedList = [];
    if (postIDListAsString == "") return convertedList;
    var stringList = postIDListAsString.split(',');
    stringList.removeAt(0); //removing empty element located in first index
    for (var str in stringList) {
      convertedList.add(int.parse(str));
    }
    return convertedList;
  }
  String getLastPostID(BasePostList list,firstTime) {
    var lastPostID = '';
    if (!firstTime) {
      lastPostID = list.getLastPostID().toString();
    }
    return lastPostID;
  }
  /// This method is used to prepare the posts that are going to be requested as string.
  Future<List<String>> preparePostToRequestString(
      PostsToDisplay? postsToDisplay,dbHelper) async {
    var postsToBeAsked = await dbHelper.getNeededPostIdList(postsToDisplay);
    String postsToBeAskedBackendIDList = '';
    for (int i = 0; i < postsToBeAsked[0].length; i++) {
      postsToBeAskedBackendIDList += ','; //add comma before each postID
      postsToBeAskedBackendIDList += postsToBeAsked[0][i].toString();
    }
    String postsToBeAskedLocalDB = '';
    for (int i = 0; i < postsToBeAsked[1].length; i++) {
      postsToBeAskedLocalDB += ','; //add comma before each postID
      postsToBeAskedLocalDB += postsToBeAsked[1][i].toString();
    }
    return [postsToBeAskedBackendIDList, postsToBeAskedLocalDB];
  }
}