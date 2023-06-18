import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/backend/BackendHelperSellBuy.dart';
import 'package:metuverse/storage/PostHandlerWithMedia.dart';
import 'package:metuverse/storage/database/database_photo/DatabaseHelperPhoto.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/db/DatabaseHelperSellBuy.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/model/BuySellPost.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';

class BuySellPostHandler extends PostHandlerWithMedia {
  final dbHelper = DatabaseHelperSellBuy();
  final backendHelper = BackendHelperSellBuy();
  final photoHelper = DatabaseHelperPhoto();
  bool initialized = false;
  bool ready = false;

  BuySellPostList sellPostList = BuySellPostList.defaults();
  BuySellPostList buyPostList = BuySellPostList.defaults();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dbHelper.init();
    await photoHelper.init();
    initialized = true;
  }
  Future<void> handlePhotos(BuySellPostList? postList) async {
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
  Future<bool> handlePostList(buyOrSell, firstTime, notificationModeFlag,notificationID) async {
    PostsToDisplay? postsToDisplay;
    if (firstTime) {
      sellPostList = BuySellPostList.defaults();
      buyPostList = BuySellPostList.defaults();
    }
    postsToDisplay = await backendHelper.requestPostsToDisplay(
        buyOrSell,
        getLastPostID(buyOrSell == 's' ? sellPostList : buyPostList, firstTime)
    );
    List<String> postsToBeAsked =
        await preparePostToRequestString(postsToDisplay,dbHelper);
    if(notificationModeFlag){
      postsToBeAsked.insert(0, notificationID);
    }
    return await handlePostListHelper(postsToBeAsked, buyOrSell);
  }
  Future<bool> handlePostListHelper(List<String> postsToBeAsked, String buyOrSell) async {
    BuySellPostList? tempPostList = (await backendHelper.getPostsFromBackend(postsToBeAsked[0])) as BuySellPostList?;
    BuySellPostList? postList = buyOrSell == 's' ? sellPostList : buyPostList;

    if (tempPostList != null) {
      postList.addNewPosts(tempPostList);
      tempPostList.posts!.forEach((element) async {
        final id = await dbHelper.insertBuySellPost(element);
      });
      handlePhotos(tempPostList);
    }

    BuySellPostList? tempPostList2 = (await dbHelper.getPostsFromLocalDB(convertIdList(postsToBeAsked[1]))) as BuySellPostList?;
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
      searchKey, filteredProductPrice, filteredCurrency, buyOrSell) async {
    BuySellPostList? tempSearchedPostList =
        await backendHelper.requestSearchPosts(
            searchKey, filteredProductPrice, filteredCurrency, buyOrSell);
    if (buyOrSell == 's') {
      sellPostList = tempSearchedPostList!;
    }
    else if (buyOrSell == 'b') {
      buyPostList = tempSearchedPostList!;
    }
    else {
      print(
          'Error in TransportationPostHandler.dart Unexpected buyOrSell value');
    }
  }
}