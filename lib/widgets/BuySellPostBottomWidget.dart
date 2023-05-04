import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_buy_sell/models/BuySellPost.dart';
import 'package:metuverse/widgets/commentPage.dart';

class BuySellPostBottomWidget extends StatelessWidget {
  const BuySellPostBottomWidget({
    super.key,
    required this.post,
  });

  final BuySellPost post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (false)
          TextButton(
            onPressed: () {
              // Change description
            },
            child: Text(
              'Change Description',
              style: kwhiteText,
            ),
          ),
        if (false)
          TextButton(
            onPressed: () {
              // Change price
            },
            child: Text(
              'Change Price',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        if (false)
          TextButton(
            onPressed: () {
              // Update availability
            },
            child: Text(
              'Update Availability',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        if (false)
          TextButton(
            onPressed: () {
              // Delete post
            },
            child: Text(
              'Delete Post',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        if (false)
          TextButton(
            onPressed: () {
// Leave a comment
            },
            child: Text(
              'Comment',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        if (!false)
          IconButton(
            onPressed: () {
// Add product to favorites
            },
            icon: Icon(Icons.add_circle_outline),
            color: Colors.blue,
          ),
        IconButton(
          onPressed: () {
            Get.to(CommentScreen());
          },
          icon: Icon(MdiIcons.comment),
          color: Colors.blue,
        ),
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