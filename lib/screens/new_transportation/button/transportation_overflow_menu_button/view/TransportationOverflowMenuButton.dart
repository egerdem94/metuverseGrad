import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_transportation/button/transportation_overflow_menu_button/controller/TransportationOverflowController.dart';
import 'package:metuverse/screens/new_transportation/create_edit_post/view/TransportationEditPostPage.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/TransportationPost.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/user/User.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';

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
        else if (value == "Report") {
          String? reportReason;

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                // Required to update the state of the dialog
                builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    title: Text('Report Post'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('Spam'),
                          leading: Radio<String>(
                            value: 'Spam',
                            groupValue: reportReason,
                            onChanged: (String? value) {
                              setState(() {
                                reportReason = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Bad word'),
                          leading: Radio<String>(
                            value: 'Bad word',
                            groupValue: reportReason,
                            onChanged: (String? value) {
                              setState(() {
                                reportReason = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Sexual content'),
                          leading: Radio<String>(
                            value: 'Sexual content',
                            groupValue: reportReason,
                            onChanged: (String? value) {
                              setState(() {
                                reportReason = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Racism'),
                          leading: Radio<String>(
                            value: 'Racism',
                            groupValue: reportReason,
                            onChanged: (String? value) {
                              setState(() {
                                reportReason = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          if (reportReason != null) {
                            String? message = await TransportationOverflowController()
                                .reportPostRequest(
                                widget.post.postID,
                                GeneralUtil.getReportReasonIndex(
                                    reportReason!));
                            if (message != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error occurred!'),
                                ),
                              );
                            }
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Report'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  );
                },
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
