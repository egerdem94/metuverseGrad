import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/BuySellPage.dart';
import 'package:metuverse/screens/new_transportation/views/TransportationPage.dart';
import 'package:metuverse/whispers/screens/WhispersPage.dart';
import 'package:metuverse/screens/home/widgets/announcementSlides.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/bottom_navigation_bar.dart';
import 'package:metuverse/widgets/drawer.dart';
import 'package:get/get.dart';
import 'package:metuverse/widgets/rounded_square_button.dart';

class HomePage extends StatelessWidget {
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
            SizedBox(
              height: 10,
            ),
            AnnouncementSlider(),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  RoundedSquareButton(
                    text: "",
                    onPressed: () {
                      Get.to(
                          BuySellPage(buyOrSell: 's', searchModeFlag: false));
                    },
                    imageUrl: 'assets-images/13717.jpg',
                  ),
                  RoundedSquareButton(
                    text: "",
                    onPressed: () {
                      Get.to(TransportationPage(
                          customerOrDriver: 'c', searchModeFlag: false));
                    },
                    imageUrl: 'assets-images/carshare.PNG',
                  ),
                  RoundedSquareButton(
                    text: "",
                    onPressed: () {
                      Get.to(WhispersPage());
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
                      //Get.to(AcademicCalendar());
                    },
                    imageUrl: 'assets-images/sport.png',
                  ),
                  RoundedSquareButton(
                    text: "",
                    onPressed: () {
                      //Get.to(NewBuySellPageX(buyOrSell: 's', searchModeFlag: false));
                    },
                    imageUrl:
                        'assets-images/Fast-food-design-Premium-vector-PNG.png',
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