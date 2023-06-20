import 'package:flutter/material.dart';

class GeneralUtil{
  static BoxDecoration buildPostBoxDecoration() {
    return BoxDecoration(
      border: Border(
          bottom:
          BorderSide(color: Color.fromARGB(255, 57, 57, 57), width: 0.5)),
    );
  }
  static BoxDecoration createPostBottomNavigationDecoration() {
    return const BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Color.fromARGB(255, 79, 79, 79),
          width: 0.2,
        ),
      ),
    );
  }
  static BoxDecoration sellBuyBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 0, 0, 0),
        ],
      ), // set the background color to blue
    );
  }
  static BoxDecoration transportationCreateBoxDecoration() {
    return BoxDecoration(
      color: Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.circular(10.0),
    );
  }
  static String getProfilePictureUrl(String? url){
    if(url == null){
      return "http://birikikoli.com/images/blank-profile-picture.jpg";
    }
    else{
      return url;
    }
  }
  static String? currencyConverter(String? currencyText) {//TODO YAVUZ DELETE?
    String currencySymbol = '';//
    if (currencyText == 'TL')
      currencySymbol = '₺';
    else if (currencyText == 'DOLLAR')
      currencySymbol = '\$';
    else if (currencyText == 'EURO')
      currencySymbol = '€';
    else if (currencyText == 'POUND') currencySymbol = '£';

    return currencySymbol;
  }
  static String currencyConverter2(String? currencyText) {
    String currencySymbol = '₺';
    if (currencyText == 'TRY')
      currencySymbol = '₺';
    else if (currencyText == 'USD')
      currencySymbol = '\$';
    else if (currencyText == 'EUR')
      currencySymbol = '€';
    else if (currencyText == 'GBP') currencySymbol = '£';

    return currencySymbol;
  }
}