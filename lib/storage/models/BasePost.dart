import 'package:metuverse/storage/models/Photo.dart';

class BasePostList{

}
class BasePost{
  bool? belongToUser;
  String? fullName;
  String? profilePicture;
  int? postID;
  int? updateVersion;
  String? media;
  String? description;
  late bool mediaExist;
  PhotoList photoList = PhotoList();

  List<String> mediaList(){
    List<String> mediaList = [];
    if (this.media != null) {
      mediaList.add(this.media!);
    }

    return mediaList;
  }
}