import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/storage/models/BasePost.dart';

class CommercialOverflowMenu extends StatelessWidget {
  const CommercialOverflowMenu({
    Key? key,
    required this.post,
  }) : super(key: key);

  final BasePost post;

  @override
  Widget build(BuildContext context) {
    final isOwnPost = post.belongToUser!; // Assuming you have a property to check if the post belongs to the user

    return PopupMenuButton<String>(
      onSelected: (String value) {
        print('Selected: $value');
      },
      itemBuilder: (BuildContext context) {
        if (isOwnPost) {
          return [
            PopupMenuItem<String>(
              value: 'Modify',
              child: Text('Modify'),
            ),
            PopupMenuItem<String>(
              value: 'Delete',
              child: Text('Delete'),
            ),
            PopupMenuItem<String>(
              value: 'Select As Found',
              child: Text('Select As Found'),
            ),
          ];
        } else {
          return [
            PopupMenuItem<String>(
              value: 'Report',
              child: Text('Report'),
            ),
          ];
        }
      },
      icon: Icon(Icons.more_vert, color: kwhiteText.color),
    );
  }
}
