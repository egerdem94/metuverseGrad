import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_buy_sell/models/BuySellPost.dart';
import 'package:metuverse/widgets/BuySellPostBottomWidget.dart';
import 'package:metuverse/widgets/TopLeftCommercialPost.dart';
import 'package:metuverse/widgets/buttons/OverflowMenuButton.dart';
import 'package:metuverse/widgets/buttons/comment_button/CommentButtonWidget.dart';
import 'package:metuverse/widgets/photo_grids/PostMediasWidget.dart';

class BuyPostContainer extends StatelessWidget {
  final BuySellPost post;

  BuyPostContainer({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom:
                BorderSide(color: Color.fromARGB(255, 57, 57, 57), width: 0.5)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //post.belongToUser!?TopLeftOwnPost(post: post):TopLeftPost(post: post),
              TopLeftCommercialPost(post: post),
              Spacer(),
              /*Text(
                  '${post.productPrice ?? 0} ${currencyConverter(post.currency ?? "")}',
                  style: kwhiteText),*/
              OverflowMenu(),
            ],
          ),
          SizedBox(height: 8.0),
          Text(post.description!, style: kwhiteText),
          SizedBox(height: 8.0),
          PostMediasWidget(post: post),
          SizedBox(height: 8.0),
          BuySellPostBottomWidget(post: post),
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
