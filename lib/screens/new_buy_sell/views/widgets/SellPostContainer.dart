import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_buy_sell/models/BuySellPost.dart';
import 'package:metuverse/screens/new_buy_sell/views/widgets/BuySellPostBottom.dart';
import 'package:metuverse/widgets/TopLeftCommercialPost.dart';
import 'package:metuverse/widgets/Util.dart';
import 'package:metuverse/buttons/OverflowMenuButton.dart';
import 'package:metuverse/buttons/comment_button/CommentButtonWidget.dart';
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
      decoration: Util.buildPostBoxDecoration(),
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
                  '${post.productPrice ?? 0} ${currencyConverter(post.currency ?? "")}',
                  style: kwhiteText),
              SizedBox(width: 8.0),
              OverflowMenu(),


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





