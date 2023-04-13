import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/new_buy_sell/views/BuySellSearchPage.dart';
import 'package:metuverse/new_transportation/views/TransportationPage.dart';
import 'package:metuverse/widgets/robot/robotPage.dart';
import 'package:metuverse/widgets/search.dart/search.dart';

class TransportationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final customerOrDriver;

  const TransportationAppBar({super.key, required this.customerOrDriver});
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
              Get.to((TransportationPage(customerOrDriver: customerOrDriver, searchModeFlag: true, departureLocation: "1", destinationLocation: "2", searchKey: "",))); //TEST PURPOSE
              //Get.to((TransportationSearchPage(customerOrDriver: customerOrDriver,))); //TODO Ege - TransportationSearchPage yapılacak.
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
