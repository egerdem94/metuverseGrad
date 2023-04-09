import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:metuverse/storage/User.dart';
import 'package:metuverse/storage/backend/IBackendHelperPostPage.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/new_buy_sell/models/BuySellPost.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';

class BackendHelperSellBuy implements IBackendHelperPostPage{

  @override
  Future<BasePostList?> getPostsFromBackend(postIDList) async {
    if(postIDList == ""){
      debugPrint("Empty postIDList in _request_buy_sell_posts_from_backend");
      return null;
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
    var temp = BuySellPostList.fromJson(jsonObject);
    return temp;
  }
  Future<BuySellPostList?> requestSearchPosts(searchKey,filteredProductPrice,filteredCurrency,buyOrSell) async{
    String serviceAddress = "http://www.birikikoli.com/mv_services/postPage/buyandsell/searchandfilter_allList.php";
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.token,
      "buyerOrSeller": buyOrSell,
      "searchKey": searchKey,
      "filteredProductPrice": filteredProductPrice,
      "filteredCurrency": filteredCurrency,
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    //if no post exists in jsonObject, return BuySellPostList.nothingFound()
    if(jsonObject['items'] == null){
      return BuySellPostList.nothingFound();
    }
    BuySellPostList buySellPostList = BuySellPostList.fromJson(jsonObject);
    return buySellPostList;
  }
  Future<PostsToDisplay?> requestPostsToDisplay(buyerOrSeller,lastPostID) async {
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



}