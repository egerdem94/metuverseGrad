import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/whisper/button/whisper_overflow_menu_button/view/WhisperOverflowMenu.dart';
import 'package:metuverse/screens/whisper/whisper_main/controller/storage/database/DatabaseHelperWhisper.dart';
import 'package:metuverse/screens/whisper/whisper_main/model/WhisperPost.dart';
import 'package:metuverse/screens/whisper/whisper_main/view/widget/WhisperPostBottom.dart';
import 'package:metuverse/widgets/TopLeftCommercialPost.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';
import 'package:metuverse/screens/new_buy_sell/button/buysell_overflow_menu_button/view/BuySellOverflowMenuButton.dart';
import 'package:metuverse/buttons/comment_button/CommentButtonWidget.dart';
import 'package:metuverse/widgets/photo_grids/PostMediasWidget.dart';

class WhisperPostContainer extends StatelessWidget {
  final WhisperPost post;
  final Function onDeletePressedArgument;
  final Function onUpdateArgument;
  final String onlineOrOfflineImage;
  final DatabaseHelperWhisper dbHelper;
  WhisperPostContainer({required this.post, required this.onDeletePressedArgument, required this.onlineOrOfflineImage, required this.onUpdateArgument, required this.dbHelper});

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
              WhisperOverflowMenu(post: post, onDeletePressedArgument: onDeletePressedArgument, onUpdateArgument: onUpdateArgument, dbHelper: dbHelper,),
            ],
          ),
          SizedBox(height: 8.0),
          Text(post.description!, style: kwhiteText),
          SizedBox(height: 8.0),
          PostMediasWidget(post: post, onlineOrOffline: onlineOrOfflineImage,),
          SizedBox(height: 8.0),
          WhisperPostBottom(post: post),
          //CommentButtonWidget(),
        ],
      ),
    );
  }
}