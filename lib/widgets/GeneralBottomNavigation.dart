import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/navigation/Navigate.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/BuySellPage.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/TransportationPage.dart';
import 'package:metuverse/screens/profile/screens/ProfilePage.dart';
import 'package:metuverse/screens/sport/sport_main/view/SportPage.dart';
import 'package:metuverse/screens/whisper/whisper_main/view/WhisperPage.dart';
import 'package:metuverse/user/User.dart';

import '../screens/home/screens/HomePage.dart';

class GeneralBottomNavigation extends StatelessWidget {
  final int pageIndex;
  const GeneralBottomNavigation({super.key, required this.pageIndex});
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
            Expanded(
              child: IconButton(
                icon: Icon(
                  MdiIcons.shopping,
                  color: pageIndex == 2 ? Colors.lightBlue : Colors.white,
                ),
                onPressed: () {
                  Get.to((BuySellPage(
                    buyOrSell: 's',
                    searchModeFlag: false,
                  )));
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  MdiIcons.carConnected,
                  color: pageIndex == 3 ? Colors.lightBlue : Colors.white,
                ),
                onPressed: () {
                  /*Get.to((TransportationPage(
                      customerOrDriver: 'c', searchModeFlag: false)));*/
                  MyNavigation.navigateToTransportation(context, 'd');
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  MdiIcons.home,
                  color: pageIndex == 10 ? Colors.lightBlue : Colors.white,
                ),
                onPressed: () {
                  //Get.to(HomePage());
                  MyNavigation.navigateToHomePage(context);
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  MdiIcons.accountGroup,
                  color: pageIndex == 1 ? Colors.lightBlue : Colors.white,
                ),
                onPressed: () {
                   /*Get.to((WhisperPage(
                      searchModeFlag: false)));*/
                  MyNavigation.navigateToWhisperPage(context);
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  MdiIcons.baseball,
                  color: pageIndex == 4 ? Colors.lightBlue : Colors.white,
                ),
                onPressed: () {
                  /*Get.to((SportPage(
                    notificationMode: null,
                    searchModeFlag: null,
                  )));*/
                  MyNavigation.navigateToSport(context);
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
