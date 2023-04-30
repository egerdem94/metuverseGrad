import 'package:flutter/material.dart';
import 'package:metuverse/storage/models/Photo.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageViewOffline extends StatelessWidget {
  final Photo photo;

  FullScreenImageViewOffline({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PhotoView(
          imageProvider: Image.memory(photo.photoData).image,
          backgroundDecoration: BoxDecoration(
            color: Colors.black,
          ),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
        ),
      ),
    );
  }
}
