import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PhotoGrid extends StatefulWidget {
  final List<String> imageUrls;
  final Function(int) onImageClicked;

  PhotoGrid({
    required this.imageUrls,
    required this.onImageClicked,
  });

  @override
  createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  final _pageController = PageController();

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
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) {
              String imageUrl = widget.imageUrls[index];
              return GestureDetector(
                child: Image.network(
                  imageUrl,
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
            count: widget.imageUrls.length,
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
