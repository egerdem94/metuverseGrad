import 'package:flutter/material.dart';
import 'package:metuverse/new_buy_sell/controllers/storage/backend/BackendHelperSellBuy.dart';
import 'package:metuverse/storage/database/database_photo/DatabaseHelperPhoto.dart';
import 'package:metuverse/new_buy_sell/controllers/storage/database/DatabaseHelperSellBuy.dart';
import 'package:metuverse/new_buy_sell/models/BuySellPost.dart';
import 'package:metuverse/storage/models/Photo.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';

class BuySellPostHandler{
  final dbHelper = DatabaseHelperSellBuy();
  final backendHelper = BackendHelperSellBuy();
  final photoHelper = DatabaseHelperPhoto();
  bool initialized = false;

  BuySellPostList sellPostList = BuySellPostList.defaults();
  BuySellPostList buyPostList = BuySellPostList.defaults();
  //PhotoList photoList = PhotoList();
  //List<int> idListForPhotos = <int>[];
  Future<void> init() async {
    //dbHelper = DatabaseHelper();
    WidgetsFlutterBinding.ensureInitialized();
    await dbHelper.init();
    await photoHelper.init();
    initialized = true;
  }

  List<int> convertIdList(postIDListAsString){
    List<int> convertedList = [];
    if(postIDListAsString == "")
      return convertedList;
    var stringList = postIDListAsString.split(',');
    stringList.removeAt(0); //removing empty element located in first index
    for(var str in stringList){
      convertedList.add(int.parse(str));
    }
    return convertedList;
  }

  String getLastPostID(buyerOrSeller,firstTime){
    var lastPostID = '';
    if(!firstTime){
      if(buyerOrSeller == 's'){
        lastPostID = sellPostList.getLastPostID().toString();
      }
      else{
        lastPostID = buyPostList.getLastPostID().toString();
      }
    }
    return lastPostID;
  }
  bool isEmpty(buyOrSell){
    if(buyOrSell == 's'){
      if(sellPostList.isEmpty()){
        return true;
      }
      else{
        return false;
      }
    }
    else{
      if(buyPostList.isEmpty()){
        return true;
      }
      else{
        return false;
      }
    }
  }
  int getLength(buyOrSell){
    if(buyOrSell == 's'){
      return sellPostList.length();
    }
    else{
      return buyPostList.length();
    }
  }
/*  List<int> postIDListHandlingForPhotos(List<String> postsToBeAsked){
    List<int> idListForPhotos = convertIdList(postsToBeAsked[0]); //firstList
    var secondList = convertIdList(postsToBeAsked[1]);
    for(int i in secondList){
      idListForPhotos.add(i);
    }
    return idListForPhotos;
  }*/
  /// This method is used to prepare the posts that are going to be requested as string.
  ///*/
  Future<List<String>> preparePostToRequestString(PostsToDisplay? postsToDisplay) async {
    //await _query();
    var postsToBeAsked = await dbHelper.getNeededPostIdList(postsToDisplay);
    String postsToBeAskedBackendIDList = '';
    for(int i = 0; i < postsToBeAsked[0].length; i++){
      postsToBeAskedBackendIDList += ','; //add comma before each postID
      postsToBeAskedBackendIDList += postsToBeAsked[0][i].toString();
    }
    String postsToBeAskedLocalDB = '';
    for(int i = 0; i < postsToBeAsked[1].length; i++){
      postsToBeAskedLocalDB += ','; //add comma before each postID
      postsToBeAskedLocalDB += postsToBeAsked[1][i].toString();
    }
    return [postsToBeAskedBackendIDList,postsToBeAskedLocalDB];
  }
  Future newHandlePhoto (BuySellPost newPostX) async{
    if(!newPostX.mediaExist){
      return;
    }
    var photoUrls = newPostX.mediaList();
    for(var photoUrl in photoUrls){
      var isExistInDB = await photoHelper.doesPhotoExist(newPostX.postID!,photoUrl);
      if(!isExistInDB){
        Photo? photo = await photoHelper.insertPhotoFromUrl(newPostX.postID!, photoUrl);
        if(photo != null){
          newPostX.addPhoto(photo);
        }
      }
      else{
        Photo? photo = await photoHelper.getPhotoGivenPostIDAndUrl(newPostX.postID!,photoUrl);
        if(photo != null){
          newPostX.addPhoto(photo);
        }
      }
    }
  }
  Future newHandlePhotos(BuySellPostList? postListX) async{
    if(postListX == null || postListX.newBuySellPostListX == null){
      return;
    }
    for(var postx in postListX.newBuySellPostListX!){
      newHandlePhoto(postx);
    }
  }

  Future<bool> handlePostList(buyOrSell,firstTime) async{
    PostsToDisplay? postsToDisplay;
    if(firstTime){
      sellPostList = BuySellPostList.defaults();
      buyPostList = BuySellPostList.defaults();
    }
    //postsToDisplay = await _request_posts_to_diplay(buyOrSell,firstTime);
    postsToDisplay = await backendHelper.requestPostsToDisplay(buyOrSell,getLastPostID(buyOrSell, firstTime));
    List<String> postsToBeAsked = await preparePostToRequestString(postsToDisplay);
    //List<int> idListOfPostsForPhotos = postIDListHandlingForPhotos(postsToBeAsked); //for photo process
    //await _requestPostsFromBackend(postsToBeAsked[0],buyOrSell);
    //await _request_buy_sell_posts_from_localdb(postsToBeAsked[1],buyOrSell);
    if(buyOrSell == 's'){
      BuySellPostList? tempPostList = (await backendHelper.getPostsFromBackend(postsToBeAsked[0])) as BuySellPostList?;
      if(tempPostList != null){
        sellPostList.addNewPosts(tempPostList);
        tempPostList.newBuySellPostListX!.forEach((element) async {
          final id = await dbHelper.insertNewBuySellPostX(element);
          //debugPrint('inserted row id: $id');
        });
        newHandlePhotos(tempPostList);
      }
      BuySellPostList? tempPostList2 = (await dbHelper.getPostsFromLocalDB(convertIdList(postsToBeAsked[1]))) as BuySellPostList?;
      newHandlePhotos(tempPostList2);
      if(tempPostList2 != null){
        sellPostList.addNewPosts(tempPostList2);
      }
      if(sellPostList.isEmpty()){
        return false;
      }
      else{
        //await handlePhotoList(buyOrSell,idListOfPostsForPhotos);
        return true;
      }
    }
    else if(buyOrSell == 'b'){
      BuySellPostList? tempPostList = (await backendHelper.getPostsFromBackend(postsToBeAsked[0])) as BuySellPostList?;
      if(tempPostList != null){
        buyPostList.addNewPosts(tempPostList);
        tempPostList.newBuySellPostListX!.forEach((element) async {
          final id = await dbHelper.insertNewBuySellPostX(element);
          //debugPrint('inserted row id: $id');
        });
        newHandlePhotos(tempPostList);
      }
      BuySellPostList? tempPostList2 = (await dbHelper.getPostsFromLocalDB(convertIdList(postsToBeAsked[1]))) as BuySellPostList?;
      newHandlePhotos(tempPostList2);
      if(tempPostList2 != null){
        buyPostList.addNewPosts(tempPostList2);
      }
      if(buyPostList.isEmpty()){
        return false;
      }
      else{
        //await handlePhotoList(buyOrSell,idListOfPostsForPhotos);
        return true;
      }
    }
    else{
      print('Error in DummyTransportationPostHandler.dart Unexpected buyOrSell value');
      return false;
    }
  }
  BuySellPostList? getBuySellPostList(buyOrSell){
    if(buyOrSell == 's'){
      return sellPostList;
    }
    else if(buyOrSell == 'b'){
      return buyPostList;
    }
    else{
      print('Error in DummyTransportationPostHandler.dart Unexpected buyOrSell value');
      return null;
    }
  }
  Future handleSearchPosts(searchKey,filteredProductPrice,filteredCurrency,buyOrSell) async{
    debugPrint("here");
      BuySellPostList? tempSearchedPostList = await backendHelper.requestSearchPosts(searchKey,filteredProductPrice,filteredCurrency,buyOrSell);
      if(buyOrSell == 's'){
        sellPostList = tempSearchedPostList!;
      }
      else if(buyOrSell == 'b'){
        buyPostList = tempSearchedPostList!;
      }
      else{
        print('Error in DummyTransportationPostHandler.dart Unexpected buyOrSell value');
      }
    debugPrint("here2");
  }
}