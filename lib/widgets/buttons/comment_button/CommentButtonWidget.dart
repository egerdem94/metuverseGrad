import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metuverse/widgets/commentPage.dart';

class CommentButtonWidget extends StatelessWidget {
  const CommentButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            Get.to(CommentScreen());
          },
          child: Text(
            'Show all comments',
            style: TextStyle(
                fontSize: 14.0,
                color: Color.fromARGB(255, 174, 174, 174)),
          ),
        ),
      ],
    );
  }
}