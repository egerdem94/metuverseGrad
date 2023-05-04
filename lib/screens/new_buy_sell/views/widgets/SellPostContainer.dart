import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_buy_sell/models/BuySellPost.dart';
import 'package:metuverse/widgets/BuySellPostBottomWidget.dart';
import 'package:metuverse/widgets/TopLeftCommercialPost.dart';
import 'package:metuverse/widgets/buttons/comment_button/CommentButtonWidget.dart';
import 'package:metuverse/widgets/commentPage.dart';
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
              TopLeftCommercialPost(post: post),
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
          BuySellPostBottomWidget(post: post),
          CommentButtonWidget(),
        ],
      ),
    );
  }
}





