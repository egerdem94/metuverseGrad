import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:get/get.dart';
import 'package:metuverse/new_buy_sell/views/BuySellSearchPage.dart';

class NewBuyAndSellAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final buyOrSell;

  const NewBuyAndSellAppBar({super.key, required this.buyOrSell});
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
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () {
              Get.to((BuySellSearchPage(
                buyOrSell: buyOrSell,
              )));
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // handle notification button press
            },
          ),
          IconButton(
            icon: Icon(Icons.mail),
            onPressed: () {
              // handle direct message button press
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
