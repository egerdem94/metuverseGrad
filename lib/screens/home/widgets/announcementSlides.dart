import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Announcement {
  final Image image;

  Announcement({required this.image});
}

List<Announcement> announcements = [
  Announcement(
    image: Image.network(
      "https://ncc.metu.edu.tr/sites/default/files/Kahramanmaras-deprem-Kibris-slider-ing.png",
    ),
  ),
  Announcement(
    image: Image.network(
      "https://ncc.metu.edu.tr/sites/default/files/Anasayfa%20%284%29_0.jpg",
    ),
  ),
  Announcement(
    image: Image.network(
      "https://ncc.metu.edu.tr/sites/default/files/qs-eeca-2022-ana-slider-ing_0.png",
    ),
  ),
];

class AnnouncementSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 100,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          //TODO: Implement onPageChanged
        },
        scrollDirection: Axis.horizontal,
      ),
      items: announcements.map((announcement) {
        return Container(
          width: 340,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: announcement.image,
          ),
        );
      }).toList(),
    );
  }
}
