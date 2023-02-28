import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:metuverse/storage/User.dart';
import 'package:metuverse/storage/backend/IBackendHelperPostPage.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/storage/models/IPostList.dart';
import 'package:metuverse/storage/models/NewBuySellPostListX.dart';

class BackendHelperSellBuy implements IBackendHelperPostPage{

  @override
  Future<IPostList?> getPostsFromBackend(postIDList) async {
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
    var temp = NewBuySellPostListX.fromJson(jsonObject);
    return temp;
  }



}