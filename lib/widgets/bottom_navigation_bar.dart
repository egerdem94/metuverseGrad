import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/profile/screens/profilePage.dart';

import '../util/user.dart';
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
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                // go back
              },
            ),
            SizedBox(width: 110.0),
            IconButton(
              icon: Icon(
                MdiIcons.home,
                color: Colors.white,
              ),
              onPressed: () {
                Get.to(ChatScreen());
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
          ],
        ),
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}
