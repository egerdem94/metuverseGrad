import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:metuverse/storage/User.dart';
import 'package:metuverse/storage/db_example/DatabaseHelperSellBuy.dart';
import 'package:metuverse/storage/db_example/DatabaseHelperSellBuy.dart';
import 'package:metuverse/storage/models/NewBuySellPostListX.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metuverse/storage/models/PostsToDisplay.dart';

class GlobalBuySellPostList{
  static final dbHelper = DatabaseHelperSellBuy();
  static List<NewBuySellPostListX?> newSellPostLists =[];
  static List<NewBuySellPostListX?> newBuyPostLists = [];

  static Future<void> init() async {
    //dbHelper = DatabaseHelper();
    WidgetsFlutterBinding.ensureInitialized();
    await dbHelper.init();
  }

  static Future _request_buy_sell_posts_from_backend(postIDList,buyOrSell) async {
    if(postIDList == ""){
      debugPrint("Empty postIDList in _request_buy_sell_posts_from_backend");
      return;
    }
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/postPage/buyandsell/dnm_buyandsell_updatedList.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.token,
      "postIDList": postIDList,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    var temp = NewBuySellPostListX.fromJson(jsonObject);
    if(buyOrSell == 's'){
      newSellPostLists.add(temp);
      /*newSellPostList!.newBuySellPostListX!.forEach((element) async {
        final id = await dbHelper.insertNewBuySellPostX(element);
        debugPrint('inserted row id: $id');
      });*/
      temp.newBuySellPostListX!.forEach((element) async {
        final id = await dbHelper.insertNewBuySellPostX(element);
        //debugPrint('inserted row id: $id');
      });
    }
    else if(buyOrSell == 'b'){
      newBuyPostLists.add(temp);
    }
    else{
      print('Error in BuySellPostHandler.dart Unexpected buyOrSell value');
    }
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
  static Future _request_buy_sell_posts_from_localdb(postIDListAsString,buyOrSell) async {
    if(postIDListAsString == ""){
      debugPrint("Empty postIDList in _request_buy_sell_posts_from_localdb");
      return;
    }
    var postsToBeAskedToLocalDBAsIntList = convertIdList(postIDListAsString);
    var tempNewBuySellPostListX = await dbHelper.queryRowsWithPostIDList(postsToBeAskedToLocalDBAsIntList);
    if(tempNewBuySellPostListX.newBuySellPostListX == null || tempNewBuySellPostListX.newBuySellPostListX!.length == 0){
      debugPrint("Empty tempNewBuySellPostListX while string is not empty!!!");
      return;
    }
    if(buyOrSell == 's'){
      newSellPostLists.add(tempNewBuySellPostListX);
    }
    else if(buyOrSell == 'b'){
      newBuyPostLists.add(tempNewBuySellPostListX);
    }
    else{
      print('Error in BuySellPostHandler.dart Unexpected buyOrSell value');
    }
  }
  static Future<PostsToDisplay?> _request_posts_to_diplay(buyerOrSeller,{lastPostID:""}) async {
    String serviceAddress = 'http://www.birikikoli.com/mv_services/postPage/buyandsell/dnm_buyandsell_latest.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.token,
      "buyerOrSeller": buyerOrSeller, //seller
      "lastPostID": lastPostID,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    PostsToDisplay? postsToDisplay;
    postsToDisplay = PostsToDisplay.fromJson(jsonObject);
    return postsToDisplay;
  }
  //debug purpose
  static Future<bool> _query() async {
    final allRows = await dbHelper.queryAllRows();
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
    return true;
  }
  /// This method is used to prepare the posts that are going to be requested as string.
  ///*/
  static Future<List<String>> preparePostToRequestString(PostsToDisplay? postsToDisplay) async {
    await _query();
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
  //function to request posts from sqlite
  static Future<NewBuySellPostListX?> requestPostsFromSqflite() async {
    final allRows = await dbHelper.queryAllRows();
    NewBuySellPostListX? newBuySellPostListX = NewBuySellPostListX();
    newBuySellPostListX.newBuySellPostListX = [];
    for (final row in allRows) {
      newBuySellPostListX.newBuySellPostListX!.add(NewBuySellPostX.fromDbMap(row));
    }
    return newBuySellPostListX;
  }

  static Future<bool> handlePostList(buyOrSell,firstTime) async{
    //newSellPostLists.add(await requestPostsFromSqflite());
    //wait 3 seconds
    //await Future.delayed(Duration(seconds: 3));

    PostsToDisplay? postsToDisplay = await _request_posts_to_diplay(buyOrSell);

    List<String> postsToBeAsked = await preparePostToRequestString(postsToDisplay);

    await _request_buy_sell_posts_from_backend(postsToBeAsked[0],buyOrSell);
    await _request_buy_sell_posts_from_localdb(postsToBeAsked[1],buyOrSell);
    if(buyOrSell == 's'){
      if(newSellPostLists != null){
        return true;
      }
      else{
        return false;
      }
    }
    else if(buyOrSell == 'b'){
      if(newBuyPostLists != null){
        return true;
      }
      else{
        return false;
      }
    }
    else{
      print('Error in BuySellPostHandler.dart Unexpected buyOrSell value');
      return false;
    }
  }

  static NewBuySellPostListX? getBuySellPostList(buyOrSell){
    if(buyOrSell == 's'){
      return newSellPostLists[0];
    }
    else if(buyOrSell == 'b'){
      return newBuyPostLists[0];
    }
    else{
      print('Error in BuySellPostHandler.dart Unexpected buyOrSell value');
      return null;
    }
  }
  static List<NewBuySellPostListX?> getBuySellPostLists(buyOrSell){
    if(buyOrSell == 's'){
      return newSellPostLists;
    }
    else if(buyOrSell == 'b'){
      return newBuyPostLists;
    }
    else{
      print('Error in BuySellPostHandler.dart Unexpected buyOrSell value');
      return [];
    }
  }
  static Future ToDoSearch() async{

  }
}

