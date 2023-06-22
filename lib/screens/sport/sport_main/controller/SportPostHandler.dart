import 'package:flutter/material.dart';
import 'package:metuverse/screens/sport/sport_main/controller/backend/BackendHelperSport.dart';
import 'package:metuverse/screens/sport/sport_main/controller/db/DatabaseHelperSport.dart';
import 'package:metuverse/screens/sport/sport_main/model/SportPost.dart';
import 'package:metuverse/storage/PostHandler.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';

class SportPostHandler extends PostHandler{
  final dbHelper = DatabaseHelperSport();
  final backendHelper = BackendHelperSport();
  bool initialized = false;
  bool ready = false;

  SportPostList sportPostList = SportPostList.defaults();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dbHelper.init();
    initialized = true;
  }
  Future<bool> handlePostList(firstTime, notificationModeFlag,notificationID) async {
    PostsToDisplay? postsToDisplay;
    List<String> postsToBeAsked;
    if (firstTime) {
      sportPostList = SportPostList.defaults();
    }
    if(notificationModeFlag){
      postsToBeAsked = ["",""];
      postsToBeAsked[0] = ',' + notificationID.toString();
    }
    else{
      postsToDisplay = await backendHelper.requestPostsToDisplay(
          getLastPostID(sportPostList, firstTime)
      );
      postsToBeAsked =
      await preparePostToRequestString(postsToDisplay,dbHelper);
    }
    return await handlePostListHelper(postsToBeAsked);
  }
  Future<bool> handlePostListHelper(List<String> postsToBeAsked) async {
    SportPostList? tempPostList = (await backendHelper.getPostsFromBackend(postsToBeAsked[0])) as SportPostList?;
    if (tempPostList != null) {
      sportPostList.addNewPosts(tempPostList);
      tempPostList.posts!.forEach((element) async {
        final id = await dbHelper.insertSportPost(element);
      });
    }
    SportPostList? tempPostList2 = (await dbHelper.getPostsFromLocalDB(convertIdList(postsToBeAsked[1]))) as SportPostList?;
    if (tempPostList2 != null) {
      sportPostList.addNewPosts(tempPostList2);
    }
    if (sportPostList.isEmpty()) {
      return false;
    } else {
      ready = true;
      return true;
    }
  }
}