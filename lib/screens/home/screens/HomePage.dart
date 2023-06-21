import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/BuySellPage.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/TransportationPage.dart';
import 'package:metuverse/screens/sport/sport_main/view/SportPage.dart';
import 'package:metuverse/screens/home/widgets/announcementSlides.dart';
import 'package:metuverse/screens/whisper/whisper_main/view/WhisperPage.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/GeneralBottomNavigation.dart';
import 'package:get/get.dart';
import 'package:metuverse/widgets/RoundedSquareButton.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MetuverseAppBar(),
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
                      Get.to(BuySellPage(
                        buyOrSell: 's',
                        searchModeFlag: false,
                      ));
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
                      Get.to(WhisperPage(
                        searchModeFlag: false,
                      ));
                      //WhisperPage
                    },
                    imageUrl: 'assets-images/istockphoto-910098436-612x612.jpg',
                  ),
/*                  RoundedSquareButton(
                    text: "",
                    onPressed: () {},
                    imageUrl: 'assets-images/book.jpg',
                  ),*/
                  RoundedSquareButton(
                    text: "",
                    onPressed: () {
                      Get.to(SportPage(
                        searchModeFlag: false,
                        notificationMode: false,
                      ));
                    },
                    imageUrl: 'assets-images/sport.png',
                  ),
/*                  RoundedSquareButton(
                    text: "",
                    onPressed: () {
                      //Get.to(NewBuySellPageX(buyOrSell: 's', searchModeFlag: false));
                    },
                    imageUrl:
                        'assets-images/Fast-food-design-Premium-vector-PNG.png',
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GeneralBottomNavigation(pageIndex: 10,),
    );
  }
}
