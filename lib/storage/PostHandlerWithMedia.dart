import 'package:metuverse/storage/PostHandler.dart';
import 'package:metuverse/storage/models/BasePostWithMedia.dart';
import 'package:metuverse/storage/models/Photo.dart';

class PostHandlerWithMedia extends PostHandler {
  Future handlePhoto(photoHelper,BasePostWithMedia basePostWithMedia) async {
    if (!basePostWithMedia.mediaExist) {
      return;
    }
    if (basePostWithMedia.isPostFromNetwork) {
      for (var photoUrl in basePostWithMedia.getMediaList()) {
        var isExistInDB =
        await photoHelper.doesPhotoExist(basePostWithMedia.postID!, photoUrl);
        if (!isExistInDB) {
          //should never exist
          Photo? photo = await photoHelper.insertPhotoFromUrl(
              basePostWithMedia.postID!, photoUrl);
          if (photo != null) {
            basePostWithMedia.addPhoto(photo);
          }
        }
      }
    } else {
      // post is obtained from local db
      //var photoUrls = buySellPost.getMediaList();
      List<String>? photoUrls =
      await photoHelper.getPhotoUrlsGivenPostID(basePostWithMedia.postID!);
      if (photoUrls == null) {
        return; //should never happen
      }
      for (var photoUrl in photoUrls) {
        var isExistInDB =
        await photoHelper.doesPhotoExist(basePostWithMedia.postID!, photoUrl);
        if (!isExistInDB) {
          //?condition should never happen, always should be proceeded to else? I am not super sure though!
          Photo? photo = await photoHelper.insertPhotoFromUrl(
              basePostWithMedia.postID!, photoUrl);
          if (photo != null) {
            basePostWithMedia.addPhoto(photo);
          }
        } else {
          Photo? photo = await photoHelper.getPhotoGivenPostIDAndUrl(
              basePostWithMedia.postID!, photoUrl);
          if (photo != null) {
            basePostWithMedia.addPhoto(photo);
          }
        }
      }
    }
  }

}