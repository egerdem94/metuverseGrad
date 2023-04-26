import 'package:flutter/material.dart';
import 'package:metuverse/home/screens/HomePage.dart';
import 'package:metuverse/login/view/LoginPage.dart';
import 'package:metuverse/logo_screen/controller/LogoBackendHelper.dart';
import 'package:metuverse/user/User.dart';
import 'package:metuverse/widgets/background-image.dart';
import 'package:metuverse/widgets/photo_grids/PhotoGridOffline.dart';
import 'package:metuverse/widgets/photo_grids/PhotoGridOnline.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  LogoBackendHelper logoBackendHelper = LogoBackendHelper();
  @override
  void initState() {
    super.initState();
    logoBackendHelper.validateToken().then((isValid) {
      if(isValid){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
      else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(),
    );
  }
}