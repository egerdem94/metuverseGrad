import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/sport/button/sport_overflow_menu_button/view/SportOverflowMenu.dart';
import 'package:metuverse/screens/sport/sport_main/controller/db/DatabaseHelperSport.dart';
import 'package:metuverse/screens/sport/sport_main/model/SportPost.dart';
import 'package:metuverse/screens/sport/sport_main/view/widget/SportPic.dart';
import 'package:metuverse/screens/sport/sport_main/view/widget/SportPostBottom.dart';
import 'package:metuverse/widgets/TopLeftCommercialPost.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';

class SportPostContainer extends StatelessWidget {
  final SportPost post;
  final Function onDeletePressedArgument;
  final Function onUpdateArgument;
  final DatabaseHelperSport dbHelper;
  SportPostContainer({required this.post, required this.onDeletePressedArgument, required this.dbHelper, required this.onUpdateArgument});

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
              SportOverflowMenu( onDeletePressedArgument: onDeletePressedArgument, onUpdateArgument: onUpdateArgument, post: post, dbHelper: dbHelper,),
            ],
          ),
          SizedBox(height: 8.0),
          Text(post.description!, style: kwhiteText),
          SizedBox(height: 8.0),
          SportImageWidget(sportID: post.sportID!,),
          SizedBox(height: 8.0),
          SportPostBottom(post: post)
        ],
      ),
    );
  }
}