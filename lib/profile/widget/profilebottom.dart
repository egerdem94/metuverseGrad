import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/home/screens/mainPage.dart';
import 'package:metuverse/profile/screens/profilePage.dart';

import '../../util/user.dart';
import '../../widgets/robot/robotPage.dart';

class ProfileBottomBar extends StatelessWidget {
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
            BackButton(
              color: Colors.white,
            ),
            SizedBox(width: 110.0),
            IconButton(
              icon: Icon(
                MdiIcons.home,
                color: Colors.white,
              ),
              onPressed: () {
                Get.to(MainPage());
              },
            ),
            SizedBox(width: 25.0),
            IconButton(
              icon: Icon(
                MdiIcons.robotHappy,
                color: Colors.white,
              ),
              onPressed: () {
                Get.to(ChatScreen());
              },
            ),
            SizedBox(width: 25.0),
            IconButton(
              icon: Icon(
                MdiIcons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Get.to(ProfilePage());
              },
            ),
          ],
        ),
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}
