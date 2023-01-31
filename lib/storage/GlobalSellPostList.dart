import 'package:metuverse/storage/User.dart';
import 'package:metuverse/storage/models/NewSellPostList2.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metuverse/storage/models/PostsToDisplay.dart';
class GlobalSellPostList{
  static NewSellPostList2? newSellPostList;

  static Future _request_sell_posts(postIDList) async {
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

    newSellPostList = NewSellPostList2.fromJson(jsonObject);

  }

  static Future<PostsToDisplay?> _request_posts_to_diplay() async {
    String serviceAddress = 'http://www.birikikoli.com/mv_services/postPage/buyandsell/dnm_buyandsell_latest.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.token,
      "buyerOrSeller": "s", //seller
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
  static Future<bool> initialApiCall() async{
    PostsToDisplay? postsToDisplay = await _request_posts_to_diplay();
    await _request_sell_posts(preparePostToRequestString(postsToDisplay));
    if(newSellPostList != null){
      return true;
    }
    else{
      return false;
    }
  }

  static NewSellPostList2? getSellPostList(){
    return newSellPostList;
  }
}

