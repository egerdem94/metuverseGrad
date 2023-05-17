import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metuverse/screens/profile/screens/profilePage.dart';
import 'package:metuverse/user/User.dart';


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
/*            Expanded(
              child: IconButton(
                icon: Icon(
                  MdiIcons.home,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.to(HomePage());
                },
              ),
            ),*/
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
