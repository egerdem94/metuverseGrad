import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/buttons/whatsapp/view/WhatsappButton.dart';
import 'package:metuverse/widgets/photo_grids/ProfilePictureCircleAvatarWidget.dart';

class TopLeftCommercialPost extends StatelessWidget {
  const TopLeftCommercialPost({
    required this.post,
  });
  final BasePost post;

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