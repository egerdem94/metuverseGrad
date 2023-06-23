import 'package:flutter/material.dart';
import 'package:metuverse/storage/models/BasePostWithMedia.dart';
import 'package:metuverse/widgets/photo_grids/FullScreenImageViewOffline.dart';
import 'package:metuverse/widgets/photo_grids/FullScreenImageViewOnline.dart';
import 'package:metuverse/widgets/photo_grids/PhotoGridOffline.dart';
import 'package:metuverse/widgets/photo_grids/PhotoGridOnline.dart';

class PostMediasWidget extends StatelessWidget {
  const PostMediasWidget({
    super.key,
    required this.post,
    required this.onlineOrOffline,
  });
  final String onlineOrOffline;
  final BasePostWithMedia post;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: post.mediaExist ? 260.0 : 10.0,
      child: post.mediaExist
          ? (onlineOrOffline == "online"
          ? PhotoGridOnline(
        imageUrls: post.mediaList!,
        onImageClicked: (index) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FullScreenImageViewOnline(
                imageUrl: post.mediaList![index],
              ),
            ),
          );
        },
      )
          : PhotoGridOffline(
        photoList: post.photoList,
        onImageClicked: (index) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FullScreenImageViewOffline(
                photo: post.photoList.photos[index],
              ),
            ),
          );
        },
      )
      )
          : Container(), // This is the empty box
    );
  }
}

