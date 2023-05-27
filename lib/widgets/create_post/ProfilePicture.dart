import 'package:flutter/material.dart';
import 'package:metuverse/user/User.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      padding: EdgeInsets.only(left: 16.0),
      child: CircleAvatar(
        backgroundImage: NetworkImage(
            GeneralUtil.getProfilePictureUrl(User.profilePicture)
        ),
      ),
    );
  }
}