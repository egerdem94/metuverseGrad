import 'package:metuverse/storage/models/Photo.dart';

class BasePostList{

}
class BasePost{
  static const String defaultProfilePictureUrl =
      "http://birikikoli.com/images/blank-profile-picture.jpg"; //empty profile picture
  bool? belongToUser;
  String? fullName;
  String? profilePicture;
  int? postID;
  int? updateVersion;
  String? description;

  BasePost({
    this.belongToUser,
    this.fullName,
    this.profilePicture,
    this.postID,
    this.updateVersion,
    this.description,
  });
  String getProfilePicture() {
    return this.profilePicture ?? defaultProfilePictureUrl;
  }
}