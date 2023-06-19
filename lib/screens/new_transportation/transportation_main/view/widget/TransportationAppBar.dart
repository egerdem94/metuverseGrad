import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:get/get.dart';
import 'package:metuverse/buttons/notification/view/NotificationButton.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/TransportationSearchPage.dart';
import 'package:metuverse/buttons/friends/view/FriendsButton.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';

class TransportationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final customerOrDriver;

  const TransportationAppBar({super.key, required this.customerOrDriver});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GeneralUtil.buildPostBoxDecoration(),
      child: AppBar(
        title: Text(
          customerOrDriver == 'd'? "Driver":"Passenger",
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
          NotificationButton(),
          FriendsButton(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}