import 'package:flutter/material.dart';
import 'package:metuverse/buttons/favorite_button/view/FavoriteButton.dart';
import 'package:metuverse/screens/sport/sport_main/model/SportPost.dart';

class SportPostBottom extends StatelessWidget {
  const SportPostBottom({
    super.key,
    required this.post,
  });

  final SportPost post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FavoriteButton(post: post,),
        Spacer(),
        Chip(
          label: Text(
            post.sportmateStatus! == 1 ? 'Active' : 'Deactive',
            style: TextStyle(
              color:
              post.sportmateStatus! == 1 ? Colors.white : Colors.black,
            ),
          ),
          backgroundColor:
          post.sportmateStatus! == 1 ? Colors.green : Colors.red,
        ),
      ],
    );
  }
}