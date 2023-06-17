import 'package:flutter/material.dart';

class SportImageWidget extends StatelessWidget {
  const SportImageWidget({
    Key? key,
    required this.sportID,
  }) : super(key: key);

  final int sportID;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260.0,
      child: Image.asset(
          getSportImagePath(),
        fit: BoxFit.cover,
      ),
    );
  }

  String getSportImagePath() {
    switch (sportID) {
      case 1:
        return 'assets-images/sports/football.jpg';
      case 2:
        return 'assets-images/sports/basketball.jpeg';
      case 3:
          return 'assets-images/sports/volleyball.jpeg';
      case 4:
        return 'assets-images/sports/tennis.jpeg';
      case 5:
        return 'assets-images/sports/squash.jpg';
      case 6:
        return 'assets-images/sports/table_tennis.webp';
      case 7:
        return 'assets-images/sports/minigolf.jpeg';
      case 8:
        return 'assets-images/sports/chess.jpeg';
      default:
        return 'assets-images/sport.png';
    }
  }
}
