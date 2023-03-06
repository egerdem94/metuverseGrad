import 'package:flutter/material.dart';
import 'package:metuverse/storage/backend/BackendHelperSellBuy.dart';
import 'package:metuverse/storage/database/DatabaseHelperSellBuy.dart';
import 'package:metuverse/storage/models/NewBuySellPostListX.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';

class BuySellPostHandler{
  static final dbHelper = DatabaseHelperSellBuy();
  static final backendHelper = BackendHelperSellBuy();
  static NewBuySellPostListX newSellPostListX = NewBuySellPostListX.defaults();
  static NewBuySellPostListX newBuyPostListX = NewBuySellPostListX.defaults();

  static Future<void> init() async {
    //dbHelper = DatabaseHelper();
    WidgetsFlutterBinding.ensureInitialized();
    await dbHelper.init();
  }

  static List<int> convertIdList(postIDListAsString){
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

  static String getLastPostID(buyerOrSeller,firstTime){
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
  /// This method is used to prepare the posts that are going to be requested as string.
  ///*/
  static Future<List<String>> preparePostToRequestString(PostsToDisplay? postsToDisplay) async {
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

  static Future<bool> handlePostList(buyOrSell,firstTime) async{

    PostsToDisplay? postsToDisplay;
    if(firstTime){
      newSellPostListX = NewBuySellPostListX.defaults();
      newBuyPostListX = NewBuySellPostListX.defaults();
    }
    //postsToDisplay = await _request_posts_to_diplay(buyOrSell,firstTime);
    postsToDisplay = await backendHelper.request_posts_to_diplay(buyOrSell,getLastPostID(buyOrSell, firstTime));
    List<String> postsToBeAsked = await preparePostToRequestString(postsToDisplay);

    //await _requestPostsFromBackend(postsToBeAsked[0],buyOrSell);
    //await _request_buy_sell_posts_from_localdb(postsToBeAsked[1],buyOrSell);
    if(buyOrSell == 's'){
      NewBuySellPostListX? temp = (await backendHelper.getPostsFromBackend(postsToBeAsked[0])) as NewBuySellPostListX?;
      if(temp != null){
        newSellPostListX.addNewPosts(temp);
        temp.newBuySellPostListX!.forEach((element) async {
          final id = await dbHelper.insertNewBuySellPostX(element);
          //debugPrint('inserted row id: $id');
        });
      }
      NewBuySellPostListX? temp2 = (await dbHelper.getPostsFromLocalDB(convertIdList(postsToBeAsked[1]))) as NewBuySellPostListX?;
      if(temp2 != null){
        newSellPostListX.addNewPosts(temp2);
      }
      if(newSellPostListX.isEmpty()){
        return false;
      }
      else{
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
        return true;
      }
    }
    else{
      print('Error in BuySellPostHandler.dart Unexpected buyOrSell value');
      return false;
    }
  }

  static NewBuySellPostListX? getBuySellPostList(buyOrSell){
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