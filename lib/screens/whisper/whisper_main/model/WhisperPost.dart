import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/db/SellBuyTableValues.dart';
import 'package:metuverse/screens/whisper/whisper_main/controller/storage/database/WhisperPostTableValues.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/storage/models/BasePostWithMedia.dart';
import 'package:metuverse/storage/models/Photo.dart';

class WhisperPostList extends BasePostList<WhisperPost> {
  bool nothingFound = false;

  WhisperPostList.nothingFound()
      : super.defaults() {
    this.nothingFound = true;
  }
  WhisperPostList.defaults(): super.defaults();

  WhisperPostList.fromJson(Map<String, dynamic> json)
      : super.defaults() {
    if (json['items'] != null) {
      this.posts = <WhisperPost>[];
      json['items'].forEach((v) {
        this.posts!.add(new WhisperPost.fromJson(v));
      });
    }
    this.total = json['total'];
  }

  WhisperPostList.fromDbMap(List<Map<String, dynamic>> json)
      : super.defaults() {
    if (json != null) {
      this.posts = <WhisperPost>[];
      json.forEach((v) {
        this.posts!.add(new WhisperPost.fromDbMap(v));
      });
    }
  }

  void addPhotos(PhotoList photos) {
    if (this.posts == null) {
      debugPrint("Unexpected!");
      return;
    }
    for (var photo in photos.photos) {
      for (var post in this.posts!) {
        if (photo.postID == post.postID) {
          post.addPhoto(photo);
          break;
        }
      }
    }
  }
}

class WhisperPost extends BasePostWithMedia {

  WhisperPost.fromJson(Map<String, dynamic> json) {
    belongToUser = json['belongToUser'];
    isFavorite = json['isFavorite'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    postID = json['postID'];
    updateVersion = json['updateVersion'];
    mediaList = json['media'].cast<String>();
    description = json['description'];
    publicToken = json['publicToken'];
    createDate = json['createDate'];
    if(mediaList == null || mediaList!.length == 0 || mediaList![0] == "http://www.birikikoli.com/images/nophoto.jpg"){
      mediaExist = false;
    }
    else{
      mediaExist = true;
    }
    /*mediaExist = (mediaList != null &&
        mediaList!.length >
            0); //mediaExist is false if mediaList is null or length is 0 and true if mediaList is not empty*/
    isPostFromNetwork = true;
  }

  WhisperPost.fromDbMap(Map<String, dynamic> json) {
    //debugPrint("belongToUser: ${json[DatabaseHelper.columnBelongToUser]}");
    json[WhisperPostTableValues.columnBelongToUser] == 1
        ? belongToUser = true
        : belongToUser = false;
    json[WhisperPostTableValues.columnIsFavorite] == 1
        ? isFavorite = true
        : isFavorite = false;
    //belongToUser = json[DatabaseHelper.columnBelongToUser];
    fullName = json[WhisperPostTableValues.columnFullName];
    profilePicture = json[WhisperPostTableValues.columnProfilePicture];
    postID = json[WhisperPostTableValues.columnPostID];
    updateVersion = json[WhisperPostTableValues.columnUpdateVersion];
    //media = json[WhisperPostTableValues.columnMedia];
    description = json[WhisperPostTableValues.columnDescription];
    publicToken = json[WhisperPostTableValues.columnPublicToken];
    createDate = json[WhisperPostTableValues.columnCreateDate];
    mediaExist = json[WhisperPostTableValues.columnMediaExist] == 1 ? true : false;
    isPostFromNetwork = false;
  }
  // Converts a NewBuySellPostX object into a Map object
  Map<String, dynamic> toDbMap() {
    int belongToUserAsInt = belongToUser == true ? 1 : 0;
    int isFavoriteAsInt = isFavorite == true ? 1 : 0;
    return {
      WhisperPostTableValues.columnPostID: postID,
      WhisperPostTableValues.columnFullName: fullName,
      WhisperPostTableValues.columnProfilePicture: profilePicture,
      WhisperPostTableValues.columnBelongToUser: belongToUserAsInt,
      WhisperPostTableValues.columnIsFavorite: isFavoriteAsInt,
      WhisperPostTableValues.columnUpdateVersion: updateVersion,
      WhisperPostTableValues.columnDescription: description,
      WhisperPostTableValues.columnPublicToken: publicToken,
      WhisperPostTableValues.columnCreateDate: createDate,
      WhisperPostTableValues.columnMediaExist: mediaExist == true ? 1 : 0,
    };
  }

  static create(
      {required int postID,
        required String title,
        required String content,
        required int price,
        required String currency,
        required List mediaList}) {}
}
