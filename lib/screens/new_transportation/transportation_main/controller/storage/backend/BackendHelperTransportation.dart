import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/NewTransportationPost.dart';
import 'package:metuverse/user/User.dart';
import 'package:metuverse/storage/backend/IBackendHelperPostPage.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/storage/models/BasePost.dart';
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
      "token": User.privateToken,
      "postIDList": postIDList,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    var temp = TransportationPostList.fromJson(jsonObject);
    return temp;
  }
  Future<PostsToDisplay?> requestPostsToDisplay(customerOrDriver,lastPostID) async {
    String serviceAddress = 'http://www.birikikoli.com/mv_services/postPage/transportation/transportation_latest.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "customerOrDriver": customerOrDriver, //seller
      "lastPostID": lastPostID,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    PostsToDisplay? postsToDisplay;
    postsToDisplay = PostsToDisplay.fromJson(jsonObject);
    return postsToDisplay;
  }

  Future<TransportationPostList?> requestSearchPosts(searchKey,departureLocation,destinationLocation,customerOrDriver) async{
    String serviceAddress =
        "http://www.birikikoli.com/mv_services/postPage/transportation/transportation_searchandfilter_allList.php";
    //debugPrint("searchKey: $searchKey" + "departureLocation: $departureLocation" +"destinationLocation: $destinationLocation" +"customerOrDriver: $customerOrDriver");
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "customerOrDriver": customerOrDriver,
      "searchKey": searchKey,
      "filteredDepartureID": departureLocation,
      "filteredDestinationID": destinationLocation,
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    //if no post exists in jsonObject, return BuySellPostList.nothingFound()
    if (jsonObject['items'] == null) {
      return TransportationPostList.nothingFound();
    }
    TransportationPostList transportationPostList = TransportationPostList.fromJson(jsonObject);
    return transportationPostList;
  }

}