import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:metuverse/screens/whisper/whisper_main/model/WhisperPost.dart';
import 'package:metuverse/user/User.dart';
import 'package:metuverse/storage/backend/IBackendHelperPostPage.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';

class BackendHelperWhisper implements IBackendHelperPostPage {
  @override
  Future<BasePostList?> getPostsFromBackend(postIDList) async {
    if (postIDList == "") {
      debugPrint("Empty postIDList in _request_whisper_posts_from_backend");
      return null;
    }
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/postPage/whisper/whisper_updatedList.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "postIDList": postIDList,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    var temp = WhisperPostList.fromJson(jsonObject);
    return temp;
  }

  Future<WhisperPostList?> requestSearchPosts(
      searchKey) async {
    String serviceAddress =
        "http://www.birikikoli.com/mv_services/postPage/whisper/whisper_searchandfilterPost.php";
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "searchKey": searchKey,
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    //if no post exists in jsonObject, return WhisperPostList.nothingFound()
    if (jsonObject['items'] == null) {
      return WhisperPostList.nothingFound();
    }
    WhisperPostList whisperPostList = WhisperPostList.fromJson(jsonObject);
    return whisperPostList;
  }

  Future<PostsToDisplay?> requestPostsToDisplay(lastPostID) async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/postPage/whisper/whisper_latest.php';
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
