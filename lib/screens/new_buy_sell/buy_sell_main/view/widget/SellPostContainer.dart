import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/model/BuySellPost.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/BuySellPostBottom.dart';
import 'package:metuverse/widgets/TopLeftCommercialPost.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';
import 'package:metuverse/buttons/overflow_menu_button/commercial_overflow_menu_button/view/CommercialOverflowMenuButton.dart';
import 'package:metuverse/buttons/comment_button/CommentButtonWidget.dart';
import 'package:metuverse/widgets/photo_grids/PostMediasWidget.dart';

class SellPostContainer extends StatefulWidget {
  final BuySellPost post;
  final Function onDeletePressedArgument;
  SellPostContainer({required this.post, required this.onDeletePressedArgument});

  @override
  _SellPostContainerState createState() => _SellPostContainerState();
}

class _SellPostContainerState extends State<SellPostContainer> {
  bool isPostDeleted = false;
  @override
  Widget build(BuildContext context) {
    if (isPostDeleted) {
      // If the post is deleted, return an empty container or any desired UI representation
      return Container();
    }

    return Container(
      decoration: GeneralUtil.buildPostBoxDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TopLeftCommercialPost(post: widget.post),
              Spacer(),
              Text(
                '${widget.post.productPrice ?? 0} ${GeneralUtil.currencyConverter(widget.post.currency ?? "")}',
                style: kwhiteText,
              ),
              SizedBox(width: 8.0),
              CommercialOverflowMenu(post: widget.post, onDeletePressedArgument: widget.onDeletePressedArgument),
            ],
          ),
          SizedBox(height: 8.0),
          Text(widget.post.description ?? "", style: kwhiteText),
          SizedBox(height: 8.0),
          PostMediasWidget(post: widget.post),
          SizedBox(height: 8.0),
          BuySellPostBottom(post: widget.post),
          CommentButtonWidget(),
        ],
      ),
    );
  }
}
