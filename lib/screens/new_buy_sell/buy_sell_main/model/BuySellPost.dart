import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/db/SellBuyTableValues.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/storage/models/BasePostWithMedia.dart';
import 'package:metuverse/storage/models/Photo.dart';

class BuySellPostList extends BasePostList<BuySellPost> {
  bool nothingFound = false;

  BuySellPostList.nothingFound()
      : super.defaults() {
    this.nothingFound = true;
  }
  BuySellPostList.defaults(): super.defaults();

  BuySellPostList.fromJson(Map<String, dynamic> json)
      : super.defaults() {
    if (json['items'] != null) {
      this.posts = <BuySellPost>[];
      json['items'].forEach((v) {
        this.posts!.add(new BuySellPost.fromJson(v));
      });
    }
    this.total = json['total'];
  }

  BuySellPostList.fromDbMap(List<Map<String, dynamic>> json)
      : super.defaults() {
    if (json != null) {
      this.posts = <BuySellPost>[];
      json.forEach((v) {
        this.posts!.add(new BuySellPost.fromDbMap(v));
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

class BuySellPost extends BasePostWithMedia {
  int? productPrice;
  String? currency;
  int? productStatus;

  BuySellPost.fromJson(Map<String, dynamic> json) {
    belongToUser = json['belongToUser'];
    isFavorite = json['isFavorite'];
    publicToken = json['publicToken'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    postID = json['postID'];
    updateVersion = json['updateVersion'];
    mediaList = json['media'].cast<String>();
    description = json['description'];
    productPrice = json['productPrice'];
    currency = json['currency'];
    productStatus = json['productStatus'];
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

  BuySellPost.fromDbMap(Map<String, dynamic> json) {
    //debugPrint("belongToUser: ${json[DatabaseHelper.columnBelongToUser]}");
    json[SellBuyTableValues.columnBelongToUser] == 1
        ? belongToUser = true
        : belongToUser = false;
    json[SellBuyTableValues.columnIsFavorite] == 1
        ? isFavorite = true
        : isFavorite = false;
    //belongToUser = json[DatabaseHelper.columnBelongToUser];
    fullName = json[SellBuyTableValues.columnFullName];
    profilePicture = json[SellBuyTableValues.columnProfilePicture];
    postID = json[SellBuyTableValues.columnPostID];
    publicToken = json[SellBuyTableValues.columnPublicToken];
    updateVersion = json[SellBuyTableValues.columnUpdateVersion];
    //media = json[SellBuyTableValues.columnMedia];
    description = json[SellBuyTableValues.columnDescription];
    productPrice = json[SellBuyTableValues.columnProductPrice];
    currency = json[SellBuyTableValues.columnCurrency];
    productStatus = json[SellBuyTableValues.columnProductStatus];
    mediaExist = json[SellBuyTableValues.columnMediaExist] == 1 ? true : false;
    isPostFromNetwork = false;
  }
  // Converts a NewBuySellPostX object into a Map object
  Map<String, dynamic> toDbMap() {
    int belongToUserAsInt = belongToUser == true ? 1 : 0;
    int isFavoriteAsInt = isFavorite == true ? 1 : 0;
    return {
      SellBuyTableValues.columnPostID: postID,
      SellBuyTableValues.columnFullName: fullName,
      SellBuyTableValues.columnProfilePicture: profilePicture,
      SellBuyTableValues.columnBelongToUser: belongToUserAsInt,
      SellBuyTableValues.columnIsFavorite: isFavoriteAsInt,
      SellBuyTableValues.columnPublicToken: publicToken,
      SellBuyTableValues.columnUpdateVersion: updateVersion,
      //SellBuyTableValues.columnMedia: media,
      SellBuyTableValues.columnDescription: description,
      SellBuyTableValues.columnProductPrice: productPrice,
      SellBuyTableValues.columnCurrency: currency,
      SellBuyTableValues.columnProductStatus: productStatus,
      SellBuyTableValues.columnMediaExist: mediaExist == true ? 1 : 0,
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
