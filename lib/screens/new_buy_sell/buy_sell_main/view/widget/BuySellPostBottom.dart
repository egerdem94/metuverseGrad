import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/buttons/favorite_button/view/FavoriteButton.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/model/BuySellPost.dart';
import 'package:metuverse/widgets/commentPage.dart';

class BuySellPostBottom extends StatelessWidget {
  const BuySellPostBottom({
    super.key,
    required this.post,
  });

  final BuySellPost post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!false)
          FavoriteButton(post: post,),

        IconButton(
          onPressed: () {
            // Leave a comment
          },
          icon: Icon(Icons.send_rounded),
          color: Colors.blue,
        ),
        Spacer(),
        Chip(
          label: Text(
            post.productStatus! == 1 ? 'Available' : 'Sold',
            style: TextStyle(
              color:
              post.productStatus! == 1 ? Colors.white : Colors.black,
            ),
          ),
          backgroundColor:
          post.productStatus! == 1 ? Colors.green : Colors.red,
        ),
      ],
    );
  }
}