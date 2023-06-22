import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/sport/button/sport_overflow_menu_button/controller/SportOverflowController.dart';
import 'package:metuverse/screens/sport/create_edit_post/view/SportEditPostPage.dart';
import 'package:metuverse/screens/sport/sport_main/controller/db/DatabaseHelperSport.dart';
import 'package:metuverse/screens/sport/sport_main/model/SportPost.dart';
import 'package:metuverse/user/User.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';

class SportOverflowMenu extends StatefulWidget {
  const SportOverflowMenu({
    Key? key,
    required this.post,
    required this.onDeletePressedArgument,
    required this.onUpdateArgument,
    required this.dbHelper,
  }) : super(key: key);
  final SportPost post;
  final DatabaseHelperSport dbHelper;
  final Function onDeletePressedArgument;
  final Function onUpdateArgument;

  @override
  _SportOverflowMenuState createState() => _SportOverflowMenuState();
}

class _SportOverflowMenuState extends State<SportOverflowMenu> {
  bool isPostDeleted = false;

  Future<void> deletePost() async {
    var isDeleted =
    await SportOverflowController().deletePressed(widget.post.postID,widget.dbHelper);
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
  Future<void> toggleStatus() async {
    var isToggled = await SportOverflowController()
        .selectAsFoundPressed(widget.post.postID);
    if (isToggled) {
      widget.onUpdateArgument();
      if (widget.post.sportmateStatus == 2) {
        widget.post.sportmateStatus = 1;
      } else {
        widget.post.sportmateStatus = 2;
      }
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Post status could not be changed'),
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
        else if (value == "Modify") {
          Get.to(SportEditPostPage(sportPost: widget.post,
          ));
        }
        else if (value == "Toggle Post Status"){
          await toggleStatus();
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
                            String? message = await SportOverflowController()
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
