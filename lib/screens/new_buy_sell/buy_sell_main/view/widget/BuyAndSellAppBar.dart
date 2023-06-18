import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:get/get.dart';
import 'package:metuverse/buttons/notification/view/NotificationButton.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/BuySellSearchPage.dart';
import 'package:metuverse/buttons/friends/view/FriendsButton.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';

class BuySellAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final buyOrSell;

  const BuySellAppBar({super.key, required this.buyOrSell});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GeneralUtil.buildPostBoxDecoration(),
      child: AppBar(
        title: Text(
          buyOrSell == 's' ? "Sell": "Buy",
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
              Get.to((BuySellSearchPage(
                buyOrSell: buyOrSell,
              )));
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