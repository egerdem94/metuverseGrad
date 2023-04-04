import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/storage/models/Photo.dart';

class BasePostWithMedia extends BasePost{
  List<String>? mediaList;
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
  List<String> getMediaList(){

    if (this.mediaList != null) {
      return mediaList!;
    }
    else {
      return [];
    }
    //return ["http://www.birikikoli.com/images/postMedia/buyandsellPage/Screenshot_20230325-193725.png", "http://www.birikikoli.com/images/postMedia/buyandsellPage/Screenshot_20230325-205925.png"];
  }
  void addPhoto(Photo photo){
    photoList.addPhoto(photo);
  }
}