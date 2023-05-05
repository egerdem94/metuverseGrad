import 'dart:typed_data';
import 'package:flutter/material.dart';

class PhotoList{
  late List<Photo> photos;
  PhotoList() {
    photos = <Photo>[];
  }
  void addPhotoFromRow(Map<String,dynamic> row){
    if(!isPhotoExistInTheList(row['_photoID'])){
      this.photos.add(new Photo(row['_photoID'],row['postID'],row['photoSource'],row['photoData']));
    }
  }
  void addPhotoAsUint8List(int photoID,int postID,String photoUrl, Uint8List photoData){
    if(!isPhotoExistInTheList(photoID)) {
      this.photos.add(new Photo(photoID, postID, photoUrl, photoData));
    }
  }

  void addPhoto(Photo photo){
    //if(!isPhotoExistInTheList(photo.photoID)){
      this.photos.add(photo);
    //}
  }
  bool isPhotoExistInTheList(int photoID){
    for(var photo in photos){
      if(photoID == photo.photoID){
        debugPrint("Unexpected! Photo Exists in the list already!"); //unexpected case
        return true;
      }
    }
    return false;
  }
}
class Photo{
  late int photoID;
  late int postID;//is it true? (BigInt)
  late String photoUrl;
  late Uint8List photoData;
  late bool shouldBeInsertedToDB;
  Photo(this.photoID,this.postID,this.photoUrl,this.photoData);
  Photo.secondConstructor(this.postID,this.photoUrl,this.photoData, this.shouldBeInsertedToDB);
  /*
    static const columnPhotoID = '_photoID';
  static const columnPostID = 'postID';
  static const columnPhotoSource = 'photoSource';
  static const columnPhotoData = 'photoData';
  static const columnInsertionDate = 'insertionDate';
   */
  Photo.fromDbMap(Map<String, dynamic> json){
    photoID = json['_photoID'];
    postID = json['postID'];
    photoUrl = json['photoSource'];
    photoData = json['photoData'] as Uint8List;
  }
}
class PseudoPhoto{
  int postID;
  String photoUrl;
  PseudoPhoto(this.postID,this.photoUrl);
}