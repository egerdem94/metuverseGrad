import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:metuverse/academiccalendar/academiccalendar.dart';
import 'package:metuverse/buyandsell/screens/buyAndSellPage.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/bottom_navigation_bar.dart';
import 'package:metuverse/widgets/drawer.dart';
import 'package:get/get.dart';
import 'package:metuverse/widgets/rounded_square_button.dart';
import '../../transportation/screens/transportationPage.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MetuverseAppBar(),
      drawer: MetuverseDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 0, 0, 0),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  RoundedSquareButton(
                    text: "",
                    onPressed: () {
                      Get.to(BuySellPage());
                    },
                    imageUrl: 'assets-images/13717.jpg',
                  ),
                  RoundedSquareButton(
                    text: "",
                    onPressed: () {
                      Get.to(TransportationPage());
                    },
                    imageUrl: 'assets-images/carshare.PNG',
                  ),
                  RoundedSquareButton(
                    text: "",
                    onPressed: () {
                      // do something
                    },
                    imageUrl: 'assets-images/istockphoto-910098436-612x612.jpg',
                  ),
                  RoundedSquareButton(
                    text: "",
                    onPressed: () {},
                    imageUrl: 'assets-images/book.jpg',
                  ),
                  RoundedSquareButton(
                    text: "",
                    onPressed: () {
                      Get.to(AcademicCalendar());
                    },
                    imageUrl: 'assets-images/academiccalendar.png',
                  ),
                  RoundedSquareButton(
                    text: "Button 6",
                    onPressed: () {
                      // do something
                    },
                    imageUrl: '',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
