import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:get/get.dart';
import 'package:metuverse/screens/new_buy_sell/create_edit_post/view/BuySellEditPostPage.dart';
import 'package:metuverse/screens/whisper/button/whisper_overflow_menu_button/controller/WhisperOverflowController.dart';
import 'package:metuverse/screens/whisper/whisper_create_edit_post/view/WhisperEditPostPage.dart';
import 'package:metuverse/screens/whisper/whisper_main/controller/storage/database/DatabaseHelperWhisper.dart';
import 'package:metuverse/screens/whisper/whisper_main/model/WhisperPost.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';

class WhisperOverflowMenu extends StatefulWidget {
  const WhisperOverflowMenu({
    Key? key,
    required this.post,
    required this.onDeletePressedArgument,
    required this.onUpdateArgument,
    required this.dbHelper,
  }) : super(key: key);
  final WhisperPost post;
  final DatabaseHelperWhisper dbHelper;
  final Function onDeletePressedArgument;
  final Function onUpdateArgument;

  @override
  _WhisperOverflowMenuState createState() => _WhisperOverflowMenuState();
}

class _WhisperOverflowMenuState extends State<WhisperOverflowMenu> {
  bool isPostDeleted = false;

  Future<void> deletePost() async {
    var isDeleted =
    await WhisperOverflowController().deletePressed(widget.post.postID,widget.dbHelper);
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
          Get.to(WhisperEditPostPage(
            whisperPost: widget.post,
          ));
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
                            String? message = await WhisperOverflowController()
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
