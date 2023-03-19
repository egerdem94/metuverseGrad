import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:metuverse/storage/PhotoHandler.dart';
import 'package:metuverse/storage/database/DatabaseHelperPhoto.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/storage/models/Photo.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewPhotoGrid extends StatefulWidget {
  final BasePost basePost;
  final Function(int) onImageClicked;

  PhotoList photoList = PhotoList();

  NewPhotoGrid({
    required this.basePost,
    required this.onImageClicked,
  });

  @override
  createState() => _NewPhotoGridState();

}

class _NewPhotoGridState extends State<NewPhotoGrid> {
  final _pageController = PageController();
  late PhotoHandler photoHandler;

  @override
  void initState()  {
    super.initState();
    /*
    Post`un fotoğrafı var mı, yok mu kontrol et.
          Eğer yoksa: Fotoğraf display etme.
          Eğer varsa: devam et.

    Postun fotoğrafları database`de var mı? Kontrol et.
          Herbir fotoğraf için eğer fotoğraf database`de yoksa: Fotoğrafları internetten çek, display et ve database`e insert et.
          Eğer varsa: fotoğrafları database`den çek.
     */

    photoHandler = PhotoHandler(basePost: widget.basePost);
    //photoHandler.init(); //Future ama çalışıyor.
    photoHandler.initializePhotos().then((_) {
     setState(() {
        widget.photoList = photoHandler.getPhotoList();
     });
    });
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.basePost.photoList.photos.length,
            itemBuilder: (context, index) {
              Uint8List imageBytes = widget.basePost.photoList.photos[index].photoData;
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
            count: widget.basePost.photoList.photos.length,
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
