import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/home/screens/HomePage.dart';
import 'package:metuverse/profile/screens/profilePage.dart';

import '../user/User.dart';
import 'robot/robotPage.dart';

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
            Expanded(
              child: BackButton(
                color: Colors.white,
              ),
            ),
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
                  MdiIcons.robotHappy,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Get.to(ChatScreen());
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: CircleAvatar(
                  radius: 18.0,
                  backgroundImage: NetworkImage(
                    //"https://i.hbrcdn.com/haber/2022/03/03/kolpacino-ekrem-abi-kimdir-abidin-yerebakan-14770711_6916_amp.jpg",
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
