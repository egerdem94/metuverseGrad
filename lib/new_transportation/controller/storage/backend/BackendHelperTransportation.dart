import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:metuverse/new_transportation/model/NewTransportationPost.dart';
import 'package:metuverse/storage/User.dart';
import 'package:metuverse/storage/backend/IBackendHelperPostPage.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/new_buy_sell/models/BuySellPost.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';

class BackendHelperTransportation implements IBackendHelperPostPage{

  @override
  Future<BasePostList?> getPostsFromBackend(postIDList) async {
    if(postIDList == ""){
      debugPrint("Empty postIDList in _request_buy_sell_posts_from_backend");
      return null;
    }
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/postPage/transportation/transportation_updatedList.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.token,
      "postIDList": postIDList,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    var temp = NewTransportationPostList.fromJson(jsonObject);
    return temp;
  }
  Future<PostsToDisplay?> requestPostsToDisplay(customerOrDriver,lastPostID) async {
    String serviceAddress = 'http://www.birikikoli.com/mv_services/postPage/transportation/transportation_latest.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.token,
      "customerOrDriver": customerOrDriver, //seller
      "lastPostID": lastPostID,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    PostsToDisplay? postsToDisplay;
    postsToDisplay = PostsToDisplay.fromJson(jsonObject);
    return postsToDisplay;
  }

  requestSearchPosts(searchKey, filteredProductPrice, filteredCurrency, buyOrSell) {
    //TODO
  }

}