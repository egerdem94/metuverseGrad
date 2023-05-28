import 'package:flutter/material.dart';
import 'package:metuverse/buttons/overflow_menu_button/commercial_overflow_menu_button/controller/CommercialOverflowController.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/storage/models/BasePost.dart';

class CommercialOverflowMenu extends StatefulWidget {
  const CommercialOverflowMenu({
    Key? key,
    required this.post,
    required this.onDeletePressedArgument,
  }) : super(key: key);

  final BasePost post;
  final Function onDeletePressedArgument;
  @override
  _CommercialOverflowMenuState createState() => _CommercialOverflowMenuState();
}

class _CommercialOverflowMenuState extends State<CommercialOverflowMenu> {
  bool isPostDeleted = false;

  Future<void> deletePost() async {
    var isDeleted = await CommercialOverflowController().deletePressed(widget.post.postID);
    setState(() {
      isPostDeleted = isDeleted;
    });
    if (isDeleted) {
      widget.onDeletePressedArgument();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Post deleted'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Post could not be deleted'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOwnPost = widget.post.belongToUser!;

    return PopupMenuButton<String>(
      onSelected: (String value) {
        if (value == 'Delete') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Delete Post'),
                content: Text('Are you sure you want to delete this post?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await deletePost();
                      Navigator.of(context).pop();
                    },
                    child: Text('Yes'),
                  ),
                ],
              );
            },
          );
        }
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
