import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metuverse/screens/auth_screens/register/RegisterPage.dart';
import 'package:get/get.dart';
import 'screens/auth_screens/login/view/LoginPage.dart';
import 'screens/logo_screen/view/LogoScreen.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter LoginPage',
      theme: ThemeData(
        textTheme:
            GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: LoginPage(),
       home: LogoScreen(),//goes directly to logo screen
       getPages: [
        GetPage(
          name: '/register',
          page: () => RegisterPage(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
        ),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}