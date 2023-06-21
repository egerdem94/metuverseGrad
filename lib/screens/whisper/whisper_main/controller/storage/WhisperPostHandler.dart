import 'package:flutter/material.dart';
import 'package:metuverse/screens/whisper/whisper_main/controller/storage/backend/BackendHelperWhisper.dart';
import 'package:metuverse/screens/whisper/whisper_main/controller/storage/database/DatabaseHelperWhisper.dart';
import 'package:metuverse/screens/whisper/whisper_main/model/WhisperPost.dart';

import 'package:metuverse/storage/PostHandlerWithMedia.dart';
import 'package:metuverse/storage/database/database_photo/DatabaseHelperPhoto.dart';

import 'package:metuverse/storage/models/PostsToDisplay.dart';

class WhisperPostHandler extends PostHandlerWithMedia {
  final dbHelper = DatabaseHelperWhisper();
  final backendHelper = BackendHelperWhisper();
  final photoHelper = DatabaseHelperPhoto();
  bool initialized = false;
  bool ready = false;

  WhisperPostList whisperPostList = WhisperPostList.defaults();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dbHelper.init();
    await photoHelper.init();
    initialized = true;
  }
  Future<void> handlePhotos(WhisperPostList? postList) async {
    if (postList == null || postList.posts == null) {
      return;
    }
    var postListLength = postList.posts!.length;
    var handledPostCount = 0;
    var handledPostWithPhotoCount = 0;
    postList.posts!.forEach((post) {
      handlePhoto(photoHelper,post).then((_) {
        handledPostCount++;
        if (post.mediaExist) {
          handledPostWithPhotoCount++;
        }
        if (handledPostWithPhotoCount == 3 || handledPostCount == postListLength) {
          ready = true;
        }
      });
    });

  }
  Future<bool> handlePostList(firstTime, notificationModeFlag,notificationID) async {
    PostsToDisplay? postsToDisplay;
    List<String> postsToBeAsked;
    if (firstTime) {
      whisperPostList = WhisperPostList.defaults();
    }
    if(notificationModeFlag){
      postsToBeAsked = ["",""];
      postsToBeAsked[0] = ',' + notificationID.toString();
    }
    else{
      postsToDisplay = await backendHelper.requestPostsToDisplay(
          getLastPostID(whisperPostList, firstTime)
      );
      postsToBeAsked = await preparePostToRequestString(postsToDisplay,dbHelper);
    }
    return await handlePostListHelper(postsToBeAsked);
  }
  Future<bool> handlePostListHelper(List<String> postsToBeAsked) async {
    WhisperPostList? tempPostList = (await backendHelper.getPostsFromBackend(postsToBeAsked[0])) as WhisperPostList?;
    WhisperPostList? postList = whisperPostList;

    if (tempPostList != null) {
      postList.addNewPosts(tempPostList);
      tempPostList.posts!.forEach((element) async {
        final id = await dbHelper.insertBuySellPost(element);
      });
      handlePhotos(tempPostList);
    }

    WhisperPostList? tempPostList2 = (await dbHelper.getPostsFromLocalDB(convertIdList(postsToBeAsked[1]))) as WhisperPostList?;
    handlePhotos(tempPostList2);
    if (tempPostList2 != null) {
      postList.addNewPosts(tempPostList2);
    }

    if (postList.isEmpty()) {
      return false;
    } else {
      return true;
    }
  }
  Future handleSearchPosts(
      searchKey) async {
    WhisperPostList? tempSearchedPostList =
        await backendHelper.requestSearchPosts(
            searchKey);
    whisperPostList = tempSearchedPostList!;
  }
}