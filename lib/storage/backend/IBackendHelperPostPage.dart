import 'package:metuverse/storage/models/IPostList.dart';

abstract class IBackendHelperPostPage{
   Future<IPostList?> getPostsFromBackend(postIDList) async{
     return null;
   }

}