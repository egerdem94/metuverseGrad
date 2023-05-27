import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/db/SellBuyTableValues.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/storage/models/BasePostWithMedia.dart';
import 'package:metuverse/storage/models/Photo.dart';

class BuySellPostList extends BasePostList {
  List<BuySellPost>? posts;
  int? total;
  bool nothingFound = false;

  BuySellPostList({this.posts, this.total});
  //constructor with default values
  BuySellPostList.defaults()
      : posts = [],
        total = 0;
  //constructor with nothing found flag
  BuySellPostList.nothingFound()
      : posts = [],
        total = 0,
        nothingFound = true;
  BuySellPostList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      posts = <BuySellPost>[];
      json['items'].forEach((v) {
        posts!.add(new BuySellPost.fromJson(v));
      });
    }
    total = json['total'];
  }
  BuySellPostList.fromDbMap(List<Map<String, dynamic>> json) {
    if (json != null) {
      posts = <BuySellPost>[];
      json.forEach((v) {
        posts!.add(new BuySellPost.fromDbMap(v));
      });
    }
  }

  /*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.newBuySellPostListX != null) {
      data['items'] = this.newBuySellPostListX!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }*/
  //function sorts the list by postID
  void sortListByPostID() {
    posts!.sort((b, a) => a.postID!.compareTo(b.postID!));
  }

  BuySellPost? getPostWithID(int id) {
    if (posts == null) {
      return null;
    }
    for (var post in posts!) {
      if (id == post.postID) {
        return post;
      }
    }
    return null;
  }

  bool isEmpty() {
    if (posts == null || posts!.length == 0)
      return true;
    else
      return false;
  }

  //function adds new posts to the list
  // if the postID is already in the list, it is not added
  // comparison is done by postID
  void addNewPosts(BuySellPostList newPosts) {
    newPosts.posts!.forEach((element) {
      addNewPost(element);
    });
    sortListByPostID(); // IMPORTANT! This might be a bad idea. You might do ordering while inserting!
  }

  void addNewPost(BuySellPost newBuySellPostX) {
    bool postIDAlreadyExists = false;
    bool postIDAlreadyExistsButUpdated = false;
    posts!.forEach((newElement) {
      if (newBuySellPostX.postID == newElement.postID) {
        if (newElement.updateVersion! > newBuySellPostX.updateVersion!) {
          postIDAlreadyExistsButUpdated = true;
        } else {
          postIDAlreadyExists = true;
        }
      }
    });
    if (!postIDAlreadyExists) {
      posts!.add(newBuySellPostX);
    } else if (postIDAlreadyExistsButUpdated) {
      //replace the old post with the new one
      for (int i = 0; i < posts!.length; i++) {
        if (posts![i].postID == newBuySellPostX.postID) {
          posts![i] = newBuySellPostX;
        }
      }
    }
  }

  //function returns the deletes the post with the given postID
  void deletePost(int postID) {
    posts!.removeWhere((element) => element.postID == postID);
  }

  void addPhotos(PhotoList photos) {
    if (posts == null) {
      debugPrint("Unexpected!");
      return;
    }
    for (var photo in photos.photos) {
      for (var post in posts!) {
        if (photo.postID == post.postID) {
          post.addPhoto(photo);
          break;
        }
      }
    }
  }

  //function returns the last postID in the list
  int getLastPostID() {
    sortListByPostID();
    return posts!.last.postID!;
  }

  int length() {
    if (posts == null) {
      return 0;
    } else {
      return posts!.length;
    }
  }
}

class BuySellPost extends BasePostWithMedia {
  int? productPrice;
  String? currency;
  int? productStatus;

  BuySellPost.fromJson(Map<String, dynamic> json) {
    belongToUser = json['belongToUser'];
    isFavorite = false;//json['isFavorite'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    postID = json['postID'];
    updateVersion = json['updateVersion'];
    mediaList = json['media'].cast<String>();
    description = json['description'];
    productPrice = json['productPrice'];
    currency = json['currency'];
    productStatus = json['productStatus'];
    mediaExist = (mediaList != null &&
        mediaList!.length >
            0); //mediaExist is false if mediaList is null or length is 0 and true if mediaList is not empty
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
      SellBuyTableValues.columnUpdateVersion: updateVersion,
      //SellBuyTableValues.columnMedia: media,
      SellBuyTableValues.columnDescription: description,
      SellBuyTableValues.columnProductPrice: productPrice,
      SellBuyTableValues.columnCurrency: currency,
      SellBuyTableValues.columnProductStatus: productStatus,
      SellBuyTableValues.columnMediaExist: mediaExist == true ? 1 : 0,
    };
  }
}
