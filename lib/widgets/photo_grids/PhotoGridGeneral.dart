import 'package:flutter/material.dart';
import 'package:metuverse/storage/models/Photo.dart';
import 'package:metuverse/widgets/photo_grids/PhotoGridOffline.dart';
import 'package:metuverse/widgets/photo_grids/PhotoGridOnline.dart';

class PhotoGridGeneral extends StatefulWidget {
  final List<String> imageUrls;
  final PhotoList? photoList;
  final Function(int) onImageClicked;

  PhotoGridGeneral({
    required this.imageUrls,
    required this.onImageClicked,
    required this.photoList,
  });

  @override
  createState() => _PhotoGridGeneralState();
}

//if photoList is null, then we are using online images using PhotoGridOnline widget
//if photoList is not null, then we are using offline images using PhotoGridOffline widget
class _PhotoGridGeneralState extends State<PhotoGridGeneral> {
  @override
  Widget build(BuildContext context) {
    return widget.photoList == null || widget.photoList!.photos.length == 0
        ? PhotoGridOnline(
            imageUrls: widget.imageUrls, onImageClicked: widget.onImageClicked)
        : PhotoGridOffline(
            photoList: widget.photoList, onImageClicked: widget.onImageClicked);
  }
}
