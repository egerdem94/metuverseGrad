import 'package:flutter/material.dart';
import 'package:metuverse/buttons/favorite_button/controller/FavoriteButtonController.dart';
import 'package:metuverse/storage/models/BasePost.dart';

class FavoriteButton extends StatefulWidget {
  final BasePost post;

  FavoriteButton({required this.post});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}
class _FavoriteButtonState extends State<FavoriteButton> {
  late bool isButtonClicked;
  FavoriteButtonController favoriteButtonController = FavoriteButtonController();
  @override
  void initState() {
    super.initState();
    favoriteButtonController.init();
    isButtonClicked = widget.post.isFavorite!;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        // Perform the API call here
        bool newButtonClicked = await favoriteButtonController.onFavoriteButtonPressed(widget.post);
        setState(() {
          isButtonClicked = newButtonClicked;
        });
      },
      icon: Icon(Icons.add_circle_outline),
      color: isButtonClicked ? Colors.red : Colors.blue,
    );
  }
}
