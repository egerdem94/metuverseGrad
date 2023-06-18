import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/model/BuySellPost.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/BuySellPostBottom.dart';
import 'package:metuverse/widgets/TopLeftCommercialPost.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';
import 'package:metuverse/screens/new_buy_sell/button/buysell_overflow_menu_button/view/BuySellOverflowMenuButton.dart';
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
              BuySellOverflowMenu(post: post, onDeletePressedArgument: onDeletePressedArgument, buyOrSell: "b",),
            ],
          ),
          SizedBox(height: 8.0),
          Text(post.description!, style: kwhiteText),
          SizedBox(height: 8.0),
          PostMediasWidget(post: post, onlineOrOffline: onlineOrOfflineImage,),
          SizedBox(height: 8.0),
          BuySellPostBottom(post: post),
          //CommentButtonWidget(),
        ],
      ),
    );
  }
}