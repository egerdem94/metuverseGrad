import 'package:flutter/material.dart';
import 'package:metuverse/new_transportation/model/NewTransportationPost.dart';
import 'package:metuverse/new_transportation/views/widgets/DepartureDestinationBox.dart';
import 'package:metuverse/new_transportation/views/widgets/TransportationPostBottom.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/widgets/TopLeftCommercialPost.dart';
import 'package:metuverse/widgets/Util.dart';
import 'package:metuverse/widgets/buttons/OverflowMenuButton.dart';
import 'package:metuverse/widgets/buttons/comment_button/CommentButtonWidget.dart';

class TransportationCustomerContainer extends StatelessWidget {
  final NewTransportationPost post;

  TransportationCustomerContainer({required this.post});

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
              TopLeftCommercialPost(post: post),
              Spacer(),
              OverflowMenu(),
            ],
          ),
          SizedBox(height: 8.0),
          Text(post.description!, style: kwhiteText),
          SizedBox(height: 8.0),
          DepartureDestinationBoxes(post: post),
          SizedBox(height: 8.0),
          TransportationCustomerPostBottom(post: post),
          CommentButtonWidget(),
        ],
      ),
    );
  }
}