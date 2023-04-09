/*
import 'package:flutter/material.dart';
import 'package:metuverse/storage/database/database_photo/DatabaseHelperPhoto.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/storage/models/Photo.dart';
import 'package:http/http.dart' as http;

class PhotoHandler {
  final DatabaseHelperPhoto dataBaseHelperPhoto = DatabaseHelperPhoto();
  final BasePost basePost;
  PhotoList photoList = PhotoList();

  PhotoHandler({
    required this.basePost
  });

  Future<void> init() async {
    //dbHelper = DatabaseHelper();
    WidgetsFlutterBinding.ensureInitialized();
    await dataBaseHelperPhoto.init();
  }

  Future<bool> initializePhotos() async {
    await init();
    if(!basePost.mediaExist) {
      //TODO: Fotoğrafı display etme.
    }

    else {

      var photoUrls = basePost.mediaList();

      for(var photoUrl in photoUrls) {
        if(await dataBaseHelperPhoto.doesPhotoExist(basePost.postID!, photoUrl)) {
          Photo? photo = await dataBaseHelperPhoto.getPhotoGivenPostIDAndUrl(basePost.postID!, photoUrl);

          if(photo != null) {
            photo.shouldBeInsertedToDB = false;
            photoList.addPhoto(photo);
          }

        }

        else {
          final response = await http.get(Uri.parse(photoUrl));
          final photoData = response.bodyBytes;
          Photo photo = Photo.secondConstructor(basePost.postID!, photoUrl, photoData, true);
          photoList.addPhoto(photo);
          //await dataBaseHelperPhoto.insertNewPhotos(photoList);
        }
      }

      await dataBaseHelperPhoto.insertNewPhotos(photoList);
    }
    return true;
  }

  PhotoList getPhotoList() {
    return this.photoList;
  }
}*/
