import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metuverse/screens/auth_screens/login/view/LoginPage.dart';
import 'package:metuverse/auth/screens/verification-page.dart';
import 'package:get/get.dart';

import '../../generalResponse.dart';
import '../../widgets/background-image.dart';
import '../widgets/login-text-input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();

  generalResponse? generalResponseObject;
  bool passwordVisibilityBool = true;

  void dispose() {
    // Clean up the controller when the widget is disposed.
    email.dispose();
    password.dispose();
    username.dispose();
    mobileNumber.dispose();
    super.dispose();
  }

  void _mail_verificationCode_send() async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/mail_verificationCode_send.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http
        .post(serviceUri, body: {"subject": "Register", "email": email.text});

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);

    setState(() {
      generalResponseObject = generalResponse.fromJson(jsonObject);
    });
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
                          'Register',
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
                          'Create a new account',
                          style: kBodyText,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              LoginTextInput(
                                icon: FontAwesomeIcons.user,
                                hint: 'Name Surname',
                                inputType: TextInputType.text,
                                inputAction: TextInputAction.next,
                                passwordObscured: false,
                                enterInfo: username,
                              ),
                              SizedBox(
                                height: 10,
                              ),
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
                                height: 20,
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
                                        _mail_verificationCode_send();
                                        Timer(Duration(seconds: 3), () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "${generalResponseObject?.message}"),
                                          ));

                                          if (generalResponseObject
                                                  ?.processStatus ==
                                              true)
                                            Get.to(VerificationPage(
                                                email: email.text,
                                                username: username.text,
                                                password: password.text));
                                        });

                                        //_loginService();
                                        /*_loginServicePost();
                                        Timer(Duration(seconds: 3), () {
                                          if (login?.id == -1) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text("Domain hatali"),
                                            ));
                                          } else if (login?.id == -2) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Kullanici bilgileri hatali"),
                                            ));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "${login?.email} olarak giris yaptiniz."),
                                            ));
                                          }
                                        });*/
                                      },
                                      child: Text(
                                        'Register',
                                        style: kLoginButtonText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account?",
                                    style: kDonthaveAccountText,
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Login',
                                      style: kCreateText,
                                    ),
                                    onPressed: () {
                                      Get.to(LoginPage());
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ]))
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
