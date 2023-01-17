import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metuverse/auth/screens/Register-page.dart';
import 'auth/screens/login-page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}
/*void main() {
  Get.put<AuthProvider>(AuthProvider());
  runApp(MyApp());
}*/

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
      home: LoginPage(),
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
    );
  }
}
