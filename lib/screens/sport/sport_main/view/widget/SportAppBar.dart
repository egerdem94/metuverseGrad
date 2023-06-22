import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:get/get.dart';
import 'package:metuverse/buttons/notification/view/NotificationButton.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/BuySellSearchPage.dart';
import 'package:metuverse/buttons/friends/view/FriendsButton.dart';
import 'package:metuverse/screens/sport/sport_main/view/SportSearchPage.dart';

class SportAppBar extends StatelessWidget
    implements PreferredSizeWidget {

  const SportAppBar({super.key});
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
        title: Text(
          "Sport",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () {
              Get.to((SportSearchPage()));
            },
          ),
          NotificationButton(),
          FriendsButton(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}