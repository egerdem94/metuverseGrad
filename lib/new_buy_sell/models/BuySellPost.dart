import 'package:flutter/material.dart';
import 'package:metuverse/new_buy_sell/controllers/storage/database/DatabaseHelperSellBuy.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/storage/models/Photo.dart';
class BuySellPostList extends BasePostList{
  List<BuySellPost>? newBuySellPostListX;
  int? total;
  bool nothingFound = false;

  BuySellPostList({this.newBuySellPostListX, this.total});
  //constructor with default values
  BuySellPostList.defaults()
      : newBuySellPostListX = [],
        total = 0;
  //constructor with nothing found flag
  BuySellPostList.nothingFound()
      : newBuySellPostListX = [],
        total = 0,
        nothingFound = true;
  BuySellPostList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      newBuySellPostListX = <BuySellPost>[];
      json['items'].forEach((v) {
        newBuySellPostListX!.add(new BuySellPost.fromJson(v));
      });
    }
    total = json['total'];
  }
  BuySellPostList.fromDbMap(List<Map<String, dynamic>> json) {
    if (json != null) {
      newBuySellPostListX = <BuySellPost>[];
      json.forEach((v) {
        newBuySellPostListX!.add(new BuySellPost.fromDbMap(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.newBuySellPostListX != null) {
      data['items'] = this.newBuySellPostListX!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
  //function sorts the list by postID
  void sortListByPostID(){
    newBuySellPostListX!.sort((b, a) => a.postID!.compareTo(b.postID!));
  }
  BuySellPost? getPostWithID(int id){
    if(newBuySellPostListX == null){
      return null;
    }
    for(var post in newBuySellPostListX!){
      if(id == post.postID){
        return post;
      }
    }
    return null;
  }
  bool isEmpty(){
    if(newBuySellPostListX == null || newBuySellPostListX!.length == 0)
      return true;
    else
      return false;
  }
  //function adds new posts to the list
  // if the postID is already in the list, it is not added
  // comparison is done by postID
  void addNewPosts(BuySellPostList newPosts){
    newPosts.newBuySellPostListX!.forEach((element) {
      addNewPost(element);
    });
    sortListByPostID();// IMPORTANT! This might be a bad idea. You might do ordering while inserting!
  }
  void addNewPost(BuySellPost newBuySellPostX){
    bool postIDAlreadyExists = false;
    bool postIDAlreadyExistsButUpdated = false;
    newBuySellPostListX!.forEach((newElement) {
      if(newBuySellPostX.postID == newElement.postID){
        if(newElement.updateVersion! > newBuySellPostX.updateVersion!){
          postIDAlreadyExistsButUpdated = true;
        }
        else{
          postIDAlreadyExists = true;
        }
      }
    });
    if(!postIDAlreadyExists){
      newBuySellPostListX!.add(newBuySellPostX);
    }
    else if(postIDAlreadyExistsButUpdated){
      //replace the old post with the new one
      for(int i = 0; i < newBuySellPostListX!.length; i++){
        if(newBuySellPostListX![i].postID == newBuySellPostX.postID){
          newBuySellPostListX![i] = newBuySellPostX;
        }
      }
    }
  }

  //function returns the deletes the post with the given postID
  void deletePost(int postID){
    newBuySellPostListX!.removeWhere((element) => element.postID == postID);
  }
  void addPhotos(PhotoList photos){
    if(newBuySellPostListX == null){
      debugPrint("Unexpected!");
      return;
    }
    for(var photo in photos.photos){
      for(var post in newBuySellPostListX!){
        if(photo.postID == post.postID){
          post.addPhoto(photo);
          break;
        }
      }
    }
  }
  //function returns the last postID in the list
  int getLastPostID(){
    sortListByPostID();
    return newBuySellPostListX!.last.postID!;
  }
  int length(){
    if(newBuySellPostListX == null){
      return 0;
    }
    else{
      return newBuySellPostListX!.length;
    }
  }
}

class BuySellPost extends BasePost{

  int? productPrice;
  String? currency;
  int? productStatus;

  BuySellPost.fromJson(Map<String, dynamic> json) {
    belongToUser = json['belongToUser'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    postID = json['postID'];
    updateVersion = json['updateVersion'];
    media = json['media'];
    description = json['description'];
    productPrice = json['productPrice'];
    currency = json['currency'];
    productStatus = json['productStatus'];
    mediaExist = true;
  }

  BuySellPost.fromDbMap(Map<String, dynamic> json) {
    //debugPrint("belongToUser: ${json[DatabaseHelper.columnBelongToUser]}");
    json[DatabaseHelperSellBuy.columnBelongToUser] == 1
        ? belongToUser = true
        : belongToUser = false;
    //belongToUser = json[DatabaseHelper.columnBelongToUser];
    fullName = json[DatabaseHelperSellBuy.columnFullName];
    profilePicture = json[DatabaseHelperSellBuy.columnProfilePicture];
    postID = json[DatabaseHelperSellBuy.columnPostID];
    updateVersion = json[DatabaseHelperSellBuy.columnUpdateVersion];
    media = json[DatabaseHelperSellBuy.columnMedia];
    description = json[DatabaseHelperSellBuy.columnDescription];
    productPrice = json[DatabaseHelperSellBuy.columnProductPrice];
    currency = json[DatabaseHelperSellBuy.columnCurrency];
    productStatus = json[DatabaseHelperSellBuy.columnProductStatus];
    mediaExist = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['belongToUser'] = this.belongToUser;
    data['fullName'] = this.fullName;
    data['profilePicture'] = this.profilePicture;
    data['postID'] = this.postID;
    data['updateVersion'] = this.updateVersion;
    data['media'] = this.media;
    data['description'] = this.description;
    data['productPrice'] = this.productPrice;
    data['currency'] = this.currency;
    data['productStatus'] = this.productStatus;
    return data;
  }
  // Converts a NewBuySellPostX object into a Map object
  Map<String, dynamic> toDbMap() {
    int belongToUserAsInt = belongToUser == true ? 1 : 0;
    return {
      DatabaseHelperSellBuy.columnPostID: postID,
      DatabaseHelperSellBuy.columnFullName: fullName,
      DatabaseHelperSellBuy.columnProfilePicture: profilePicture,
      DatabaseHelperSellBuy.columnBelongToUser: belongToUserAsInt,
      DatabaseHelperSellBuy.columnUpdateVersion: updateVersion,
      DatabaseHelperSellBuy.columnMedia: media,
      DatabaseHelperSellBuy.columnDescription: description,
      DatabaseHelperSellBuy.columnProductPrice: productPrice,
      DatabaseHelperSellBuy.columnCurrency: currency,
      DatabaseHelperSellBuy.columnProductStatus: productStatus,
    };
  }

  bool doesMediaExist(){
    if(mediaExist == true){
      return true;
    }
    else{
      return false;
    }
  }
/*  void addPhoto(Photo photo){
    this.photoList.addPhoto(photo);
  }*/
  String getProfilePicture(){
    if (this.profilePicture != null) {
      return this.profilePicture!;
    }
    else{
      //return "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";
      return "http://birikikoli.com/images/blank-profile-picture.jpg";
    }
  }
}