import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/BuySellPage.dart';
import 'package:metuverse/screens/new_transportation/views/TransportationPage.dart';
import 'package:metuverse/screens/profile/screens/profilePage.dart';
import 'package:metuverse/screens/sport/sport_main/view/SportPage.dart';
import 'package:metuverse/user/User.dart';

import '../screens/home/screens/HomePage.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromARGB(255, 79, 79, 79),
            width: 0.3,
          ),
        ),
      ),
      child: BottomAppBar(
        child: Row(
          children: [
            /*Expanded(
              child: BackButton(
                color: Colors.white,
              ),
            ),*/
            Expanded(
              child: IconButton(
                icon: Icon(
                  MdiIcons.home,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.to(HomePage());
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  MdiIcons.shopping,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.to((BuySellPage(
                    buyOrSell: 's',
                    searchModeFlag: false,
                    notificationMode: false,
                  )));
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  MdiIcons.carConnected,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.to((TransportationPage(
                      customerOrDriver: 'c', searchModeFlag: false)));
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  MdiIcons.accountGroup,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Get.to((TransportationPage(
                  //     customerOrDriver: 'c', searchModeFlag: false)));
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  MdiIcons.baseball,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.to((SportPage(
                    notificationMode: null,
                    searchModeFlag: null,
                  )));
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: CircleAvatar(
                  radius: 18.0,
                  backgroundImage: NetworkImage(
                    User.profilePicture,
                  ),
                ),
                onPressed: () {
                  Get.to(ProfilePage());
                },
              ),
            ),
          ],
        ),
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}
