import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_transportation/button/transportation_overflow_menu_button/view/TransportationOverflowMenuButton.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/TransportationPost.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/widget/DepartureDestinationBox.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/widget/TransportationPostBottom.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/widgets/TopLeftCommercialPost.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';
import 'package:metuverse/buttons/comment_button/CommentButtonWidget.dart';

class TransportationCustomerContainer extends StatelessWidget {
  final TransportationPost post;
  final Function onDeletePressedArgument;
  TransportationCustomerContainer({required this.post, required this.onDeletePressedArgument});

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
              TransportationOverflowMenu(post: post, onDeletePressedArgument: onDeletePressedArgument,),
            ],
          ),
          SizedBox(height: 8.0),
          Text(post.description!, style: kwhiteText),
          SizedBox(height: 8.0),
          DepartureDestinationBoxes(post: post),
          SizedBox(height: 8.0),
          TransportationCustomerPostBottom(post: post),
          //CommentButtonWidget(),
        ],
      ),
    );
  }
}
