import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metuverse/buttons/friends/view/MessageRequestsPage.dart';

class FriendsButton extends StatelessWidget {
  const FriendsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.people),
      onPressed: () {
        //Go to MessageRequestsPage
        Get.to(FriendsPage());
      },
    );
  }
}