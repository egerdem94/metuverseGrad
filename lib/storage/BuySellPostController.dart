import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:metuverse/storage/User.dart';
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
  static Future _request_buy_sell_posts(postIDList,buyOrSell) async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/postPage/buyandsell/dnm_buyandsell_updatedList.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.token,
      "postIDList": postIDList,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    if(buyOrSell == 's'){
      newSellPostLists.add(NewBuySellPostListX.fromJson(jsonObject));
      /*newSellPostList!.newBuySellPostListX!.forEach((element) async {
        final id = await dbHelper.insertNewBuySellPostX(element);
        debugPrint('inserted row id: $id');
      });*/
    }
    else if(buyOrSell == 'b'){
      newBuyPostLists.add(NewBuySellPostListX.fromJson(jsonObject));
    }
    else{
      print('Error in BuySellPostController.dart Unexpected buyOrSell value');
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
  static Future<String> preparePostToRequestString(PostsToDisplay? postsToDisplay) async {
    //await _query();
    String postIDList = '';
    if(postsToDisplay != null){
      for(int i = 0; i < postsToDisplay.postsToDisplayList!.length; i++){
        postIDList += ','; //add comma before each postID
        postIDList += postsToDisplay.postsToDisplayList![i].postID.toString();
      }
    }
    return postIDList;
  }
  //function to request posts from sqflite
  static Future<NewBuySellPostListX?> requestPostsFromSqflite() async {
    final allRows = await dbHelper.queryAllRows();
    NewBuySellPostListX? newBuySellPostListX = NewBuySellPostListX();
    newBuySellPostListX.newBuySellPostListX = [];
    for (final row in allRows) {
      newBuySellPostListX.newBuySellPostListX!.add(NewBuySellPostX.fromDbMap(row));
    }
    return newBuySellPostListX;
  }

  static Future<bool> initialBuySellApiCall(buyOrSell) async{
    debugPrint("here1");
    //newSellPostLists.add(await requestPostsFromSqflite());
    //wait 3 seconds
    //await Future.delayed(Duration(seconds: 3));
    debugPrint("here2");
    PostsToDisplay? postsToDisplay = await _request_posts_to_diplay(buyOrSell);
    debugPrint("here3");
    await _request_buy_sell_posts(await preparePostToRequestString(postsToDisplay),buyOrSell);
    debugPrint("here4");
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
      print('Error in BuySellPostController.dart Unexpected buyOrSell value');
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
      print('Error in BuySellPostController.dart Unexpected buyOrSell value');
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
      print('Error in BuySellPostController.dart Unexpected buyOrSell value');
      return [];
    }
  }
  static Future ToDoSearch() async{

  }
}

