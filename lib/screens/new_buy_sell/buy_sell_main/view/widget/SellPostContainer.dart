import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/model/BuySellPost.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/BuySellPostBottom.dart';
import 'package:metuverse/widgets/TopLeftCommercialPost.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';
import 'package:metuverse/buttons/overflow_menu_button/commercial_overflow_menu_button/view/CommercialOverflowMenuButton.dart';
import 'package:metuverse/buttons/comment_button/CommentButtonWidget.dart';
import 'package:metuverse/widgets/photo_grids/PostMediasWidget.dart';


class SellPostContainer extends StatelessWidget {
  final BuySellPost post;
  SellPostContainer({required this.post});

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
              //post.belongToUser!?TopLeftOwnPost(post: post):TopLeftPost(post: post),
              TopLeftCommercialPost(post: post),
              Spacer(),
              Text(
                  '${post.productPrice ?? 0} ${GeneralUtil.currencyConverter(post.currency ?? "")}',
                  style: kwhiteText),
              SizedBox(width: 8.0),
              CommercialOverflowMenu(post: post,),
            ],
          ),
          SizedBox(height: 8.0),
          Text(post.description ?? "", style: kwhiteText),
          SizedBox(height: 8.0),
          PostMediasWidget(post: post),
          SizedBox(height: 8.0),
          BuySellPostBottom(post: post),
          CommentButtonWidget(),
        ],
      ),
    );
  }
}