import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metuverse/screens/profile/screens/OtherUserProfilePage.dart';
import 'package:metuverse/screens/profile/screens/ProfilePage.dart';
import 'package:metuverse/storage/models/BasePost.dart';

class ProfilePictureCircleAvatarWidget extends StatelessWidget {
  const ProfilePictureCircleAvatarWidget({
    super.key,
    required this.post,
  });

  final BasePost post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(post.belongToUser!){
          Get.to(ProfilePage());
        }
        else{
          Get.to(OtherUserProfilePage(
            userFullName: post.fullName,
            profilePicture: post.getProfilePicture(),
          ));
        }
      },
      child: CircleAvatar(
        backgroundImage: NetworkImage(post.getProfilePicture()),
        radius: 24.0,
      ),
    );
  }
}