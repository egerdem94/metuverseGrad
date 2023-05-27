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
  static String getProfilePictureUrl(String? url){
    if(url == null){
      return "http://birikikoli.com/images/blank-profile-picture.jpg";
    }
    else{
      return url;
    }
  }
  static String? currencyConverter(String? currencyText) {
    String currencySymbol = '';
    if (currencyText == 'TL')
      currencySymbol = '₺';
    else if (currencyText == 'DOLLAR')
      currencySymbol = '\$';
    else if (currencyText == 'EURO')
      currencySymbol = '€';
    else if (currencyText == 'POUND') currencySymbol = '£';

    return currencySymbol;
  }
}