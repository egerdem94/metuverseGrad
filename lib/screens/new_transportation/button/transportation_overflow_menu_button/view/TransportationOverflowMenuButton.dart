import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_transportation/button/transportation_overflow_menu_button/controller/TransportationOverflowController.dart';
import 'package:metuverse/screens/new_transportation/create_edit_post/view/TransportationEditPostPage.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/TransportationPost.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/user/User.dart';

class TransportationOverflowMenu extends StatefulWidget {
  const TransportationOverflowMenu({
    Key? key,
    required this.post,
    required this.onDeletePressedArgument,
    required this.onUpdateArgument,

  }) : super(key: key);

  final TransportationPost post;
  final Function onDeletePressedArgument;
  final Function onUpdateArgument;
  @override
  _TransportationOverflowMenuState createState() => _TransportationOverflowMenuState();
}

class _TransportationOverflowMenuState extends State<TransportationOverflowMenu> {
  bool isPostDeleted = false;

  Future<void> deletePost() async {
    var isDeleted = await TransportationOverflowController().deletePressed(widget.post.postID);
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
  Future<void> toggleStatus() async{
    var isToggled = await TransportationOverflowController().selectAsFoundPressed(widget.post.postID);
    if (isToggled) {
      widget.onUpdateArgument();
      if (widget.post.transportationStatus == 2) {
        widget.post.transportationStatus = 1;
        widget.post.availablePerson = 0;
      } else {
        widget.post.transportationStatus = 2;
        widget.post.availablePerson = widget.post.totalPerson;
      }
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occurred while toggling!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOwnPost = widget.post.belongToUser! || User.userRoleID == 0;

    return PopupMenuButton<String>(
      onSelected: (String value) async {
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
        else if(value == 'Toggle Post Status'){
          await toggleStatus();
        }
        else if(value == "Modify"){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => TransportationEditPostPage(
                    transportationPost: widget.post,
                  )
              )
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
              value: 'Toggle Post Status',
              child: Text('Toggle Post Status'),
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
