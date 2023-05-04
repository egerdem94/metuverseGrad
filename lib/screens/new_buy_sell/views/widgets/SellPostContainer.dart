import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_buy_sell/models/BuySellPost.dart';
import 'package:metuverse/widgets/buttons/comment_button/CommentButtonWidget.dart';
import 'package:metuverse/widgets/buttons/whatsapp/view/WhatsappButton.dart';
import 'package:metuverse/widgets/commentPage.dart';
import 'package:metuverse/widgets/photo_grids/ProfilePictureCircleAvatarWidget.dart';
import 'package:metuverse/widgets/photo_grids/PostMediasWidget.dart';


class SellPostContainer extends StatelessWidget {
  final BuySellPost post;
  SellPostContainer({required this.post});

  String currencySymbol = '';

  String? currencyConverter(String? currencyText) {
    if (currencyText == 'TRY')
      currencySymbol = '₺';
    else if (currencyText == 'USD')
      currencySymbol = '\$';
    else if (currencyText == 'EUR')
      currencySymbol = '€';
    else if (currencyText == 'GBP') currencySymbol = '£';

    return currencySymbol;
  }

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
              TopLeftPost(post: post),
              Spacer(),
              Text(
                  '${post.productPrice ?? 0} ${currencyConverter(post.currency ?? "")}',
                  style: kwhiteText),

            ],
          ),
          SizedBox(height: 8.0),
          Text(post.description ?? "", style: kwhiteText),
          SizedBox(height: 8.0),
          PostMediasWidget(post: post),
          SizedBox(height: 8.0),
          SellPostBottomWidget(post: post),
          CommentButtonWidget(),
        ],
      ),
    );
  }
}

class TopLeftPost extends StatelessWidget {
  const TopLeftPost({
    required this.post,
  });

  final BuySellPost post;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ProfilePictureCircleAvatarWidget(post: post),
          SizedBox(width: 8.0),
          Text(post.fullName ?? "", style: kUsersText),
          if (!post.belongToUser!) ...[
            SizedBox(width: 8.0),
            WhatsappButton(post: post),
          ],
        ],
      ),
    );
  }
}


class SellPostBottomWidget extends StatelessWidget {
  const SellPostBottomWidget({
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




