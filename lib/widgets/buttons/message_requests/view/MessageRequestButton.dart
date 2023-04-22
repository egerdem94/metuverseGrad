import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metuverse/widgets/buttons/message_requests/view/MessageRequestsPage.dart';

class MessageRequestButton extends StatelessWidget {
  const MessageRequestButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.mail),
      onPressed: () {
        //Go to MessageRequestsPage
        Get.to(MessageRequestsPage());
      },
    );
  }
}