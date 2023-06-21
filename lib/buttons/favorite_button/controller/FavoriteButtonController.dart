import 'package:metuverse/buttons/favorite_button/controller/FavoriteButtonBackendHelper.dart';
import 'package:metuverse/buttons/favorite_button/controller/FavoriteButtonDbHelper.dart';
import 'package:metuverse/storage/models/BasePost.dart';

class FavoriteButtonController{
  FavoriteButtonDbHelper dbHelper = FavoriteButtonDbHelper();
  FavoriteButtonBackendHelper backendHelper = FavoriteButtonBackendHelper();
  Future init() async {
    await dbHelper.init();
  }
  Future<bool> onFavoriteButtonPressed(BasePost post) async {
    var status = await backendHelper.toggleFavoriteRequest(post.postID, post.isFavorite);
    if(status){
      post.isFavorite = !post.isFavorite!;
      bool isSuccessFull = await dbHelper.toggleFavorite(post);
      if(isSuccessFull){
        return post.isFavorite!;
      }
      else{
        post.isFavorite = !post.isFavorite!;
        return post.isFavorite!;
      }
    }
    else return false;

  }
}