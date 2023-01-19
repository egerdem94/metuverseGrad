import 'package:flutter/material.dart';
import 'package:metuverse/buyandsell/screens/AddProduct.dart';
import 'package:get/get.dart';
import 'package:metuverse/buyandsell/screens/lookingforPage.dart';
import 'package:metuverse/home/screens/mainPage.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/transportation/screens/transportationCarPage.dart';
import 'package:metuverse/transportation/screens/transportationPage.dart';
import 'package:metuverse/transportation/screens/transportationPostingPage.dart';

import '../../util/user.dart';
import 'transportationContainer.dart';

class CustomTransportationBottomNavigationBar extends StatelessWidget {
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
                Get.to(MainPage());
                // go back
              },
            ),
            SizedBox(
              width: 25,
            ),
            IconButton(
                icon: new Icon(
                  MdiIcons.humanGreeting,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.to(TransportationPage());
                }),
            Expanded(
              child: Container(
                height: 40.0, // set the height of the home icon
                child: Center(
                  child: Container(
                    height: 40.0, // set the size of the home icon
                    width: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(29, 161, 242, 1),
                      border: Border.all(
                        color: Color.fromRGBO(29, 161, 242, 1),
                        width: 2.0,
                      ),
                    ),
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.to(TransportationPostingPage());
                      },
                      shape: CircleBorder(), // set the shape to a circle
                      backgroundColor: Colors
                          .transparent, // make the background transparent so that the border is visible
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                MdiIcons.carConnected,
                color: Colors.white,
              ),
              onPressed: () {
                Get.to(TransportationCarPage());
              },
            ),
            SizedBox(
              width: 25,
            ),
            IconButton(
              icon: CircleAvatar(
                radius: 18.0,
                backgroundImage: NetworkImage(
                  //"https://i.hbrcdn.com/haber/2022/03/03/kolpacino-ekrem-abi-kimdir-abidin-yerebakan-14770711_6916_amp.jpg",
                  User.profilePicture,
                ),
              ),
              onPressed: () {
                // navigate to the profile page
              },
            ),
          ],
        ),
        color: Color.fromARGB(255, 0, 0, 0),
        shape: CircularNotchedRectangle(),
        // add a notch to accommodate the home icon
      ),
    );
  }
}
