import 'package:flutter/material.dart';
import 'package:metuverse/screens/home/screens/HomePage.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/BuySellPage.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/TransportationPage.dart';
import 'package:metuverse/screens/sport/sport_main/view/SportPage.dart';
import 'package:metuverse/screens/whisper/whisper_main/view/WhisperPage.dart';

class MyNavigation extends Navigator{
  static navigateToHomePage(context){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()
        )
    );
  }
  static navigateToWhisperPage(context){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => WhisperPage(searchModeFlag: false,)
        )
    );
  }
  static navigateToSellBuy(context,buyOrSell){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BuySellPage(buyOrSell: buyOrSell, searchModeFlag: false,)
        )
    );
  }
  static navigateToTransportation(context,customerOrDriver){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TransportationPage(customerOrDriver: customerOrDriver, searchModeFlag: false,)
        )
    );
  }
  static navigateToSport(context){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SportPage(searchModeFlag: false, notificationMode: false,)
        )
    );
  }
}