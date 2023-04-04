import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/storage/models/Photo.dart';

class BasePostWithMedia extends BasePost{
  String? media;
  late bool mediaExist;
  PhotoList photoList = PhotoList();

  //TODO why not using?
  bool doesMediaExist(){
    if(mediaExist == true){
      return true;
    }
    else{
      return false;
    }
  }
  List<String> mediaList(){
    List<String> mediaList = [];
    if (this.media != null) {
      mediaList.add(this.media!);
    }

    return mediaList;
  }
  void addPhoto(Photo photo){
    photoList.addPhoto(photo);
  }
}