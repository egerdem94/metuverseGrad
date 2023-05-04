import 'package:flutter/material.dart';
import 'package:metuverse/storage/models/BasePostWithMedia.dart';
import 'package:metuverse/widgets/photo_grids/FullScreenImageViewOffline.dart';
import 'package:metuverse/widgets/photo_grids/PhotoGridOffline.dart';

class PostMediasWidget extends StatelessWidget {
  const PostMediasWidget({
    super.key,
    required this.post,
  });

  final BasePostWithMedia post;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260.0,
      child: PhotoGridOffline(
        photoList: post.photoList,
        onImageClicked: (index) {
          // Show fullscreen image view
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FullScreenImageViewOffline(
                photo: post.photoList.photos[index],
              ),
            ),
          );
        },
      ),
    );
  }
}