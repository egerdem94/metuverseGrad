import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/backend/BackendHelperSellBuy.dart';
import 'package:metuverse/storage/database/database_photo/DatabaseHelperPhoto.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/db/DatabaseHelperSellBuy.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/model/BuySellPost.dart';
import 'package:metuverse/storage/models/Photo.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';

class BuySellPostHandler {
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
  String getLastPostID(buyerOrSeller, firstTime) {
    var lastPostID = '';
    if (!firstTime) {
      if (buyerOrSeller == 's') {
        lastPostID = sellPostList.getLastPostID().toString();
      } else {
        lastPostID = buyPostList.getLastPostID().toString();
      }
    }
    return lastPostID;
  }
  /// This method is used to prepare the posts that are going to be requested as string.
  Future<List<String>> preparePostToRequestString(
      PostsToDisplay? postsToDisplay) async {
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
  Future handlePhoto(BuySellPost buySellPost) async {
    if (!buySellPost.mediaExist) {
      return;
    }
    if (buySellPost.isPostFromNetwork) {
      for (var photoUrl in buySellPost.getMediaList()) {
        var isExistInDB =
            await photoHelper.doesPhotoExist(buySellPost.postID!, photoUrl);
        if (!isExistInDB) {
          //should never exist
          Photo? photo = await photoHelper.insertPhotoFromUrl(
              buySellPost.postID!, photoUrl);
          if (photo != null) {
            buySellPost.addPhoto(photo);
          }
        }
      }
    } else {
      // post is obtained from local db
      //var photoUrls = buySellPost.getMediaList();
      List<String>? photoUrls =
          await photoHelper.getPhotoUrlsGivenPostID(buySellPost.postID!);
      if (photoUrls == null) {
        return; //should never happen
      }
      for (var photoUrl in photoUrls) {
        var isExistInDB =
            await photoHelper.doesPhotoExist(buySellPost.postID!, photoUrl);
        if (!isExistInDB) {
          //?condition should never happen, always should be proceeded to else? I am not super sure though!
          Photo? photo = await photoHelper.insertPhotoFromUrl(
              buySellPost.postID!, photoUrl);
          if (photo != null) {
            buySellPost.addPhoto(photo);
          }
        } else {
          Photo? photo = await photoHelper.getPhotoGivenPostIDAndUrl(
              buySellPost.postID!, photoUrl);
          if (photo != null) {
            buySellPost.addPhoto(photo);
          }
        }
      }
    }
  }
  Future<void> handlePhotos(BuySellPostList? postList) async {
    if (postList == null || postList.posts == null) {
      return;
    }
    var postListLength = postList.posts!.length;
    var handledPostCount = 0;
    postList.posts!.forEach((post) {
      handlePhoto(post).then((_) {
        handledPostCount++;
        if (handledPostCount == 3 || handledPostCount == postListLength) {
          ready = true;
        }
      });
    });

  }
  Future<bool> handlePostList(buyOrSell, firstTime) async {
    PostsToDisplay? postsToDisplay;
    if (firstTime) {
      sellPostList = BuySellPostList.defaults();
      buyPostList = BuySellPostList.defaults();
    }
    postsToDisplay = await backendHelper.requestPostsToDisplay(
        buyOrSell, getLastPostID(buyOrSell, firstTime));
    List<String> postsToBeAsked =
        await preparePostToRequestString(postsToDisplay);
    if (buyOrSell == 's' || buyOrSell == 'b') {
      return await handlePostListHelper(postsToBeAsked, buyOrSell);
    }
    else {
      print(
          'Error in TransportationPostHandler.dart Unexpected buyOrSell value');
      return false;
    }
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
    } else if (buyOrSell == 'b') {
      buyPostList = tempSearchedPostList!;
    } else {
      print(
          'Error in TransportationPostHandler.dart Unexpected buyOrSell value');
    }
  }
}