import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/model/BuySellPost.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/BuySellPostBottom.dart';
import 'package:metuverse/widgets/TopLeftCommercialPost.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';
import 'package:metuverse/buttons/overflow_menu_button/commercial_overflow_menu_button/view/CommercialOverflowMenuButton.dart';
import 'package:metuverse/buttons/comment_button/CommentButtonWidget.dart';
import 'package:metuverse/widgets/photo_grids/PostMediasWidget.dart';

class BuyPostContainer extends StatelessWidget {
  final BuySellPost post;
  final Function onDeletePressedArgument;
  final String onlineOrOfflineImage;
  BuyPostContainer({required this.post, required this.onDeletePressedArgument, required this.onlineOrOfflineImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GeneralUtil.buildPostBoxDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TopLeftCommercialPost(post: post),
              Spacer(),
              CommercialOverflowMenu(post: post, onDeletePressedArgument: onDeletePressedArgument,),
            ],
          ),
          SizedBox(height: 8.0),
          Text(post.description!, style: kwhiteText),
          SizedBox(height: 8.0),
          PostMediasWidget(post: post, onlineOrOffline: onlineOrOfflineImage,),
          SizedBox(height: 8.0),
          BuySellPostBottom(post: post),
          CommentButtonWidget(),
        ],
      ),
    );
  }
}

/*
//TODO To be deleted
class BuyPostButtom extends StatelessWidget {
  const BuyPostButtom({
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
              // Leave a comment
            },
            icon: Icon(Icons.comment_rounded),
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
            post.productStatus! == 1 ? 'Looking' : 'Found',
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
}*/
