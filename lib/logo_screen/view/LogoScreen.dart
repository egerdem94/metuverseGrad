import 'package:flutter/material.dart';
import 'package:metuverse/home/screens/HomePage.dart';
import 'package:metuverse/login/view/LoginPage.dart';
import 'package:metuverse/user/User.dart';
import 'package:metuverse/widgets/photo_grids/PhotoGridOffline.dart';
import 'package:metuverse/widgets/photo_grids/PhotoGridOnline.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();
    _validateToken();
  }

  Future<void> _validateToken() async {
    // Simulate token validation from backend (Replace this with your actual token validation logic)
    //await Future.delayed(Duration(microseconds: 300));

    // Assuming token validation result (true for valid, false for invalid)
    bool tokenIsValid = true;

    if (tokenIsValid) {
      User.fullName = "Yavuz Erbaş";
      User.profilePicture = "http://www.birikikoli.com/images/profileMedia/userID3.jpeg";
      User.userName = "mrerbas";
      User.privateToken = "EBQqnAwwP4qD4fRIXgwnZ7m70jvclzpZagpxQW3G";
      // Navigate to Home Screen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      // Navigate to Login Screen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
          PhotoGridOnline( //TODO Ege bizim logo ile degisecek
            imageUrls: ["https://cdn.logo.com/hotlink-ok/logo-social.png"],
            onImageClicked: (index) {
              print('Image clicked: $index');
            },
          ),
      ),
    );
  }
}