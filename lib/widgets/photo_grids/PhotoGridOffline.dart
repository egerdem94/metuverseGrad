import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:metuverse/storage/models/Photo.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PhotoGridOffline extends StatefulWidget {
  final PhotoList? photoList;
  final Function(int) onImageClicked;

  PhotoGridOffline({
    required this.photoList,
    required this.onImageClicked,
  });

  @override
  createState() => _PhotoGridOfflineState();
}

class _PhotoGridOfflineState extends State<PhotoGridOffline> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.photoList == null || widget.photoList!.photos.length == 0) {
      return Text('No photos to display');
    } else {
      return Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.photoList!.photos.length,
              itemBuilder: (context, index) {
                Uint8List imageBytes =
                    widget.photoList!.photos[index].photoData;
                return GestureDetector(
                  child: Image.memory(
                    imageBytes,
                    fit: BoxFit.cover,
                  ),
                  onTap: () => widget.onImageClicked(index),
                );
              },
            ),
          ),
          Container(
            height: 20,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: widget.photoList!.photos.length,
              effect: WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                spacing: 8,
                activeDotColor: Colors.blue,
                dotColor: Colors.grey,
              ),
            ),
          ),
        ],
      );
    }
  }
}
