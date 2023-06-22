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
  late bool isFavorited;
  bool isApiCallOnProgress = false;
  FavoriteButtonController favoriteButtonController = FavoriteButtonController();
  @override
  void initState() {
    super.initState();
    favoriteButtonController.init();
    isFavorited = widget.post.isFavorite!;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        if(!isApiCallOnProgress){
          isApiCallOnProgress = true;
          bool status = await favoriteButtonController.onFavoriteButtonPressed(widget.post);
          setState(() {
            isFavorited = status;
          });
          isApiCallOnProgress = false;
        }

      },
      icon: Icon(isFavorited == true? Icons.favorite:Icons.favorite_border),
      color: isFavorited ? Colors.red : Colors.blue,
    );
  }
}
