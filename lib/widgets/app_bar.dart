import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metuverse/buttons/friends/view/FriendsButton.dart';
import 'package:metuverse/buttons/notification/view/NotificationButton.dart';
import 'package:metuverse/widgets/search.dart/search.dart';

class MetuverseAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 79, 79, 79),
            width: 0.3,
          ),
        ),
      ),
      child: AppBar(
        // leading: NotificationButton(),
        title: Text(
          "Metuverse",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
        actions: [
          /*IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () {
              Get.to(SearchPage());
            },
          ),*/
          NotificationButton(),
          /*IconButton(
            icon: Icon(Icons.mail),
            onPressed: () {
              Get.to(ChatsScreen());
            },
          )*/
          FriendsButton(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
