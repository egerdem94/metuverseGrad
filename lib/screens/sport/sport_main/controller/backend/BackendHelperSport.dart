import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:metuverse/screens/sport/sport_main/model/SportPost.dart';
import 'package:metuverse/user/User.dart';
import 'package:metuverse/storage/backend/IBackendHelperPostPage.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/model/BuySellPost.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';

class BackendHelperSport implements IBackendHelperPostPage {
  @override
  Future<BasePostList?> getPostsFromBackend(postIDList) async {
    if (postIDList == "") {
      debugPrint("Empty postIDList in getPostsFromBackend");
      return null;
    }
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/postPage/sport/sport_updatedList.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "postIDList": postIDList,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    var temp = SportPostList.fromJson(jsonObject);
    return temp;
  }

  Future<SportPostList> requestSearchPosts(
      searchKey, filteredSportID) async {
    String serviceAddress =
        "http://www.birikikoli.com/mv_services/postPage/sport/sport_searchandfilter_allList.php";
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "searchKey": searchKey,
      "filteredSportID": filteredSportID,
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    //if no post exists in jsonObject, return BuySellPostList.nothingFound()
    if (jsonObject['items'] == null) {
      return SportPostList.nothingFound();
    }
    SportPostList sportPostList = SportPostList.fromJson(jsonObject);
    return sportPostList;
  }

  Future<PostsToDisplay?> requestPostsToDisplay(lastPostID) async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/postPage/sport/sport_latest.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "lastPostID": lastPostID,
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    PostsToDisplay? postsToDisplay;
    postsToDisplay = PostsToDisplay.fromJson(jsonObject);
    return postsToDisplay;
  }
}
