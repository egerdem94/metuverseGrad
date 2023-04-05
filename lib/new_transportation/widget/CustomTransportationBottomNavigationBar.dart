import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:metuverse/home/screens/HomePage.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/new_transportation/views/NewTransportationPage.dart';
import 'package:metuverse/new_transportation/views/transportationCarPage.dart';
import 'package:metuverse/new_transportation/views/transportationPage.dart';
import 'package:metuverse/new_transportation/views/TransportationCreatePostPage.dart';
import 'package:metuverse/profile/screens/profilePage.dart';
import 'package:metuverse/storage/User.dart';



import 'TransportationCustomerContainer.dart';

class CustomTransportationBottomNavigationBar extends StatelessWidget {
  final customerOrDriver;

  const CustomTransportationBottomNavigationBar({super.key, required this.customerOrDriver});
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
                Get.to(HomePage());
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
                  //Get.to(TransportationPage());
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          //builder: (context) => TransportationPage(driverOrPassenger: 'p', searchModeFlag: false,)
                          builder: (context) => NewTransportationPage(customerOrDriver: 'c', searchModeFlag: false,)
                      )
                  );
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
                        Get.to(TransportationCreatePostPage());
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
                //Get.to(TransportationCarPage());
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        //builder: (context) => TransportationPage(driverOrPassenger: 'd', searchModeFlag: false,)
                        builder: (context) => NewTransportationPage(customerOrDriver: 'd', searchModeFlag: false,)
                    )
                );
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
                Get.to(ProfilePage());
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
