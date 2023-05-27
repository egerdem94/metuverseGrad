import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:metuverse/buttons/notification/model/MyNotification.dart';
import 'package:metuverse/buttons/notification/view/NotificationPage.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.notifications),
      onPressed: () {
        Get.to(NotificationPage(notificationList: NotificationList.fromDummy(),));
      },
    );
  }
}