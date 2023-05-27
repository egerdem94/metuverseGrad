import 'package:metuverse/buttons/favorite_button/controller/FavoriteButtonDbHelper.dart';
import 'package:metuverse/storage/models/BasePost.dart';

class FavoriteButtonController{
  FavoriteButtonDbHelper dbHelper = FavoriteButtonDbHelper();
  Future init() async {
    await dbHelper.init();
  }
  Future<bool> onFavoriteButtonPressed(BasePost post) async {
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
}