import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/screens/home/screens/HomePage.dart';
import 'package:metuverse/screens/profile/screens/ProfilePage.dart';
import 'package:metuverse/user/User.dart';

class MainPageNavigationBar extends StatelessWidget {
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
            /*IconButton(
              icon: Icon(
                MdiIcons.robotHappy,
                color: Colors.white,
              ),
              onPressed: () {
                //Get.to(ChatScreen());
              },
            ),*/
            SizedBox(width: 25.0),
            IconButton(
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
          ],
        ),
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}
