import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/button/buysell_overflow_menu_button/controller/BuySellOverflowController.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/model/BuySellPost.dart';
import 'package:get/get.dart';
import 'package:metuverse/screens/new_buy_sell/create_edit_post/view/BuySellEditPostPage.dart';

class BuySellOverflowMenu extends StatefulWidget {
  const BuySellOverflowMenu({
    Key? key,
    required this.post,
    required this.onDeletePressedArgument,
    required this.buyOrSell,
  }) : super(key: key);
  final buyOrSell;
  final BuySellPost post;
  final Function onDeletePressedArgument;
  @override
  _BuySellOverflowMenuState createState() => _BuySellOverflowMenuState();
}

class _BuySellOverflowMenuState extends State<BuySellOverflowMenu> {
  bool isPostDeleted = false;

  Future<void> deletePost() async {
    var isDeleted = await BuySellOverflowController().deletePressed(widget.post.postID);
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
  Future<void> selectAsFound() async{
      var isToggled = await BuySellOverflowController().selectAsFoundPressed(widget.post.postID);
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
        else if(value == 'Select As Found'){
          await selectAsFound();
        }
        else if(value == "Modify"){
          Get.to(BuySellEditPostPage(
            buyOrSell: widget.buyOrSell, buySellPost: widget.post,
          ));
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
