import 'package:metuverse/storage/models/BasePost.dart';

abstract class IBackendHelperPostPage{
   Future<BasePostList?> getPostsFromBackend(postIDList) async{
     return null;
   }

}