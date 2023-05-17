import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:get/get.dart';
import 'package:metuverse/screens/new_transportation/views/TransportationSearchPage.dart';
import 'package:metuverse/buttons/friends/view/FriendsButton.dart';

class TransportationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
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
              Get.to((TransportationSearchPage(
                customerOrDriver: customerOrDriver,
              )));
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // handle notification button press
            },
          ),
          FriendsButton(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
