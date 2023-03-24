import 'package:flutter/material.dart';
import 'package:metuverse/storage/backend/BackendHelperSellBuy.dart';
import 'package:metuverse/storage/database/DatabaseHelperPhoto.dart';
import 'package:metuverse/storage/database/DatabaseHelperSellBuy.dart';
import 'package:metuverse/storage/models/NewBuySellPostX.dart';
import 'package:metuverse/storage/models/Photo.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';

class BuySellPostHandler{
  final dbHelper = DatabaseHelperSellBuy();
  final backendHelper = BackendHelperSellBuy();
  final photoHelper = DatabaseHelperPhoto();

  NewBuySellPostListX newSellPostListX = NewBuySellPostListX.defaults();
  NewBuySellPostListX newBuyPostListX = NewBuySellPostListX.defaults();
  //PhotoList photoList = PhotoList();
  //List<int> idListForPhotos = <int>[];
  Future<void> init() async {
    //dbHelper = DatabaseHelper();
    WidgetsFlutterBinding.ensureInitialized();
    await dbHelper.init();
    await photoHelper.init();
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
        lastPostID = newSellPostListX.getLastPostID().toString();
      }
      else{
        lastPostID = newBuyPostListX.getLastPostID().toString();
      }
    }
    return lastPostID;
  }
  List<int> postIDListHandlingForPhotos(List<String> postsToBeAsked){
    List<int> idListForPhotos = convertIdList(postsToBeAsked[0]); //firstList
    var secondList = convertIdList(postsToBeAsked[1]);
    for(int i in secondList){
      idListForPhotos.add(i);
    }
    return idListForPhotos;
  }
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
  Future newHandlePhoto (NewBuySellPostX newPostX) async{
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
  Future newHandlePhotos(NewBuySellPostListX? postListX) async{
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
      newSellPostListX = NewBuySellPostListX.defaults();
      newBuyPostListX = NewBuySellPostListX.defaults();
    }
    //postsToDisplay = await _request_posts_to_diplay(buyOrSell,firstTime);
    postsToDisplay = await backendHelper.request_posts_to_diplay(buyOrSell,getLastPostID(buyOrSell, firstTime));
    List<String> postsToBeAsked = await preparePostToRequestString(postsToDisplay);
    List<int> idListOfPostsForPhotos = postIDListHandlingForPhotos(postsToBeAsked); //for photo process
    //await _requestPostsFromBackend(postsToBeAsked[0],buyOrSell);
    //await _request_buy_sell_posts_from_localdb(postsToBeAsked[1],buyOrSell);
    if(buyOrSell == 's'){
      NewBuySellPostListX? tempPostList = (await backendHelper.getPostsFromBackend(postsToBeAsked[0])) as NewBuySellPostListX?;
      if(tempPostList != null){
        newSellPostListX.addNewPosts(tempPostList);
        tempPostList.newBuySellPostListX!.forEach((element) async {
          final id = await dbHelper.insertNewBuySellPostX(element);
          //debugPrint('inserted row id: $id');
        });
        newHandlePhotos(tempPostList);
      }
      NewBuySellPostListX? tempPostList2 = (await dbHelper.getPostsFromLocalDB(convertIdList(postsToBeAsked[1]))) as NewBuySellPostListX?;
      newHandlePhotos(tempPostList2);
      if(tempPostList2 != null){
        newSellPostListX.addNewPosts(tempPostList2);
      }
      if(newSellPostListX.isEmpty()){
        return false;
      }
      else{
        //await handlePhotoList(buyOrSell,idListOfPostsForPhotos);
        return true;
      }
    }
    else if(buyOrSell == 'b'){
      NewBuySellPostListX? temp = (await backendHelper.getPostsFromBackend(postsToBeAsked[0])) as NewBuySellPostListX?;
      if(temp != null){
        newBuyPostListX.addNewPosts(temp);
        temp.newBuySellPostListX!.forEach((element) async {
          final id = await dbHelper.insertNewBuySellPostX(element);
          //debugPrint('inserted row id: $id');
        });
      }
      NewBuySellPostListX? temp2 = (await dbHelper.getPostsFromLocalDB(convertIdList(postsToBeAsked[1]))) as NewBuySellPostListX?;
      if(temp2 != null){
        newBuyPostListX.addNewPosts(temp2);
      }
      if(newBuyPostListX.isEmpty()){
        return false;
      }
      else{
        //await handlePhotoList(buyOrSell,idListOfPostsForPhotos);
        return true;
      }
    }
    else{
      print('Error in BuySellPostHandler.dart Unexpected buyOrSell value');
      return false;
    }
  }
/*  List<PseudoPhoto> getPseudoPhoto(int id,buyOrSell){
    List<PseudoPhoto> pseudoPhotos = <PseudoPhoto>[];
    NewBuySellPostX? post;
    if(buyOrSell == 's'){
      post = newSellPostListX.getPostWithID(id);
    }
    else{
      post = newBuyPostListX.getPostWithID(id);
    }
    if(post == null){
      return pseudoPhotos;
    }
    List<String> mediaList = post.mediaList();
    if(mediaList.length == 0){
      return pseudoPhotos;
    }
    for(var media in mediaList){
      pseudoPhotos.add(PseudoPhoto(id, media));
    }
    return pseudoPhotos;
  }*/
/*  List<List<PseudoPhoto>> getPseudoPhotos(buyOrSell,idListOfPostsForPhotos){
    List<List<PseudoPhoto>> pseudoPhotos = <List<PseudoPhoto>>[];
    if(idListOfPostsForPhotos.length == 0){
      return pseudoPhotos;
    }
    for(int id in idListOfPostsForPhotos){
      List<PseudoPhoto> pseudos = getPseudoPhoto(id, buyOrSell);
      if(pseudos != []){
        pseudoPhotos.add(pseudos);
      }
    }
    return pseudoPhotos;
  }*/
/*  void feedPhotosToPosts(buyOrSell,PhotoList photoList){
    if(buyOrSell == 's'){
      newSellPostListX.addPhotos(photoList);
    }
    else{
      newBuyPostListX.addPhotos(photoList);
    }
  }*/
/*  Future handlePhotoList(buyOrSell,idListOfPostsForPhotos) async{
    await photoHelper.init();
    List<List<PseudoPhoto>> pseudoPhotosList = getPseudoPhotos(buyOrSell,idListOfPostsForPhotos);
    await photoHelper.insertPseudoLists(pseudoPhotosList);
    PhotoList photoList = await photoHelper.getPhotosGivenPostIDs(idListOfPostsForPhotos);
    feedPhotosToPosts(buyOrSell, photoList);
  }*/

  NewBuySellPostListX? getBuySellPostList(buyOrSell){
    if(buyOrSell == 's'){
      return newSellPostListX;
    }
    else if(buyOrSell == 'b'){
      return newBuyPostListX;
    }
    else{
      print('Error in BuySellPostHandler.dart Unexpected buyOrSell value');
      return null;
    }
  }
  static Future ToDoSearch() async{

  }
}