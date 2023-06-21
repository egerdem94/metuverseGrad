import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/button/buysell_overflow_menu_button/controller/BuySellOverflowController.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/model/BuySellPost.dart';
import 'package:get/get.dart';
import 'package:metuverse/screens/new_buy_sell/create_edit_post/view/BuySellEditPostPage.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';

class BuySellOverflowMenu extends StatefulWidget {
  const BuySellOverflowMenu({
    Key? key,
    required this.post,
    required this.onDeletePressedArgument,
    required this.onUpdateArgument,
    required this.buyOrSell,
  }) : super(key: key);
  final buyOrSell;
  final BuySellPost post;
  final Function onDeletePressedArgument;
  final Function onUpdateArgument;

  @override
  _BuySellOverflowMenuState createState() => _BuySellOverflowMenuState();
}

class _BuySellOverflowMenuState extends State<BuySellOverflowMenu> {
  bool isPostDeleted = false;

  Future<void> deletePost() async {
    var isDeleted =
        await BuySellOverflowController().deletePressed(widget.post.postID);
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
    var isToggled = await BuySellOverflowController()
        .selectAsFoundPressed(widget.post.postID);
    if (isToggled) {
      widget.onUpdateArgument();
      if (widget.post.productStatus == 2) {
        widget.post.productStatus = 1;
      } else {
        widget.post.productStatus = 2;
      }
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
        } else if (value == 'Toggle Post Status') {
          await toggleStatus();
        } else if (value == "Modify") {
          Get.to(BuySellEditPostPage(
            buyOrSell: widget.buyOrSell,
            buySellPost: widget.post,
          ));
        } else if (value == "Report") {
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
                            String? message = await BuySellOverflowController()
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
