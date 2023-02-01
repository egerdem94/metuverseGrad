import 'package:metuverse/storage/User.dart';
import 'package:metuverse/storage/models/NewBuySellPostListX.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metuverse/storage/models/PostsToDisplay.dart';
class GlobalBuySellPostList{
  static NewBuySellPostListX? newSellPostList;
  static NewBuySellPostListX? newBuyPostList;

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
      newSellPostList = NewBuySellPostListX.fromJson(jsonObject);
    }
    else if(buyOrSell == 'b'){
      newBuyPostList = NewBuySellPostListX.fromJson(jsonObject);
    }
    else{
      print('Error in GlobalBuySellPostList.dart Unexpected buyOrSell value');
    }


  }
/*  static Future _request_buy_posts(postIDList) async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/postPage/buyandsell/dnm_buyandsell_updatedList.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.token,
      //"buyerOrSeller": "b", //seller
      "postIDList": postIDList,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);

    newBuyPostList = NewBuySellPostList2.fromJson(jsonObject);

  }*/
  static Future<PostsToDisplay?> _request_posts_to_diplay(buyerOrSeller) async {
    String serviceAddress = 'http://www.birikikoli.com/mv_services/postPage/buyandsell/dnm_buyandsell_latest.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.token,
      "buyerOrSeller": buyerOrSeller, //seller
      "lastPostID": "5",
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    PostsToDisplay? postsToDisplay;
    postsToDisplay = PostsToDisplay.fromJson(jsonObject);
    return postsToDisplay;
  }

  /// This method is used to prepare the posts that are going to be requested as string.
  ///*/
  static String preparePostToRequestString(PostsToDisplay? postsToDisplay){
    String postIDList = '';
    if(postsToDisplay != null){
      for(int i = 0; i < postsToDisplay.postsToDisplayList!.length; i++){
        postIDList += ','; //add comma before each postID
        postIDList += postsToDisplay.postsToDisplayList![i].postID.toString();
      }
    }
    return postIDList;
  }
  static Future<bool> initialBuySellApiCall(buyOrSell) async{
    PostsToDisplay? postsToDisplay = await _request_posts_to_diplay(buyOrSell);
    await _request_buy_sell_posts(preparePostToRequestString(postsToDisplay),buyOrSell);
    if(buyOrSell == 's'){
      if(newSellPostList != null){
        return true;
      }
      else{
        return false;
      }
    }
    else if(buyOrSell == 'b'){
      if(newBuyPostList != null){
        return true;
      }
      else{
        return false;
      }
    }
    else{
      print('Error in GlobalBuySellPostList.dart Unexpected buyOrSell value');
      return false;
    }
    /*if(newSellPostList != null){
      return true;
    }
    else{
      return false;
    }*/
  }
/*  static Future<bool> initialBuyApiCall() async{
    PostsToDisplay? postsToDisplay = await _request_posts_to_diplay('b');
    await _request_buy_sell_posts(preparePostToRequestString(postsToDisplay));
    if(newBuyPostList != null){
      return true;
    }
    else{
      return false;
    }
  }*/
  static NewBuySellPostListX? getBuySellPostList(buyOrSell){
    if(buyOrSell == 's'){
      return newSellPostList;
    }
    else if(buyOrSell == 'b'){
      return newBuyPostList;
    }
    else{
      print('Error in GlobalBuySellPostList.dart Unexpected buyOrSell value');
      return null;
    }
    return newSellPostList;
  }
/*  static NewBuySellPostList2? getBuyPostList(){
    return newBuyPostList;
  }*/
}

