import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:metuverse/login/model/LoginModelX.dart';
import 'package:metuverse/palette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metuverse/home/screens/HomePage.dart';
import 'package:metuverse/storage/User.dart';
import '../../widgets/background-image.dart';
import 'package:get/get.dart';
import '../../auth/widgets/login-text-input.dart';
import '../../auth/screens/forgotPassword.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  LoginModelX? loginObject;
  bool passwordVisibilityBool = true;


  void dispose() {
    // Clean up the controller when the widget is disposed.
    email.dispose();
    password.dispose();
    super.dispose();
  }
  void insertUserValues(String token, String fullName, String? profilePicture) {
    User.token = token;
    User.fullName = fullName;
    if(profilePicture != null) {
      User.profilePicture = profilePicture;
    }
    else{
      User.profilePicture = "http://birikikoli.com/images/blank-profile-picture.jpg";
    }
  }
  void userLogin() async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/user_login.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "email": email.text,
      "passwordHash": password.text,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);

    loginObject = LoginModelX.fromJson(jsonObject);
    debugPrint("Token: " + loginObject!.token!);
    debugPrint("Full Name: " + loginObject!.fullName!);
    debugPrint("Profile Picture: " + loginObject!.profilePicture!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                //bottom overflowed (klavye) hatası için
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Metuverse',
                          style: kHeading,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Login to your account',
                          style: kBodyText,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                LoginTextInput(
                                  icon: FontAwesomeIcons.solidEnvelope,
                                  hint: 'Email',
                                  inputType: TextInputType.emailAddress,
                                  inputAction: TextInputAction.next,
                                  passwordObscured: false,
                                  enterInfo: email,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Stack(
                                  children: [
                                    LoginTextInput(
                                      icon: FontAwesomeIcons.lock,
                                      hint: 'Password',
                                      inputType: TextInputType.visiblePassword,
                                      inputAction: TextInputAction.done,
                                      passwordObscured: passwordVisibilityBool,
                                      enterInfo: password,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              passwordVisibilityBool =
                                                  !passwordVisibilityBool;
                                            });
                                          },
                                          icon: passwordVisibilityBool
                                              ? Icon(
                                                  Icons.visibility,
                                                  color: Colors.green,
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color: Colors.orange,
                                                )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(ForgotPasswordPage());
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: kForgetPasswordText,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      userLogin();
                                      Timer(Duration(seconds: 2), () {
                                        if (loginObject?.loginStatus == true) {
                                          //token = loginObject?.token;
                                          insertUserValues(
                                              loginObject?.token ?? '',
                                              loginObject?.fullName ?? '',
                                              loginObject?.profilePicture ?? null);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content:
                                            Text("Welcome to Metuverse ${loginObject?.fullName}"),
                                          ));

                                          Get.to(HomePage());
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text("Incorrect login, please check your entries."),
                                          ));
                                        }
                                      });
                                    },
                                    child: Text(
                                      'Login',
                                      style: kLoginButtonText,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: kDonthaveAccountText,
                                ),
                                TextButton(
                                  child: Text(
                                    'Create Now',
                                    style: kCreateText,
                                  ),
                                  onPressed: () {
                                    Get.toNamed('/register');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            )),
      ],
    );
  }
}