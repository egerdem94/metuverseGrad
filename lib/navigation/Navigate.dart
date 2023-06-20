import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/TransportationPage.dart';

class MyNavigation extends Navigator{
  static navigateToTransportation(context,customerOrDriver,searchModeFlag){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TransportationPage(customerOrDriver: customerOrDriver, searchModeFlag: searchModeFlag,)
        )
    );
  }
}