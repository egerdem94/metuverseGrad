import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:metuverse/screens/auth_screens/widgets/AuthTextInput.dart';
import 'package:metuverse/widgets/background-image.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class LoginModel {
  int? id;
  String? email;

  LoginModel.fromMap({required Map json})
      : id = json["Id"].runtimeType == int ? json["Id"] : int.parse(json["Id"]),
        email = json["Email"];
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController email = TextEditingController();

  LoginModel? login;

  get kPrimaryColor => null;

  void dispose() {
    // Clean up the controller when the widget is disposed.
    email.dispose();
    super.dispose();
  }

  void _forgotPasswordServicePost() async {
    String serviceAddress = 'http://www.birikikoli.com/get.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(Uri.parse(serviceAddress), body: {
      "Email": email.text,
    });

    String stringData = response.body;
    Map jsonObject = jsonDecode(stringData);

    login = LoginModel.fromMap(json: jsonObject);
  }

  void _forgotPasswordServiceGet() async {
    String serviceAddress = 'http://www.birikikoli.com/get.php';
    Uri serviceUri = Uri.parse(serviceAddress);

    HttpClientRequest request = await HttpClient().getUrl(serviceUri);
    HttpClientResponse response = await request.close();
    String stringData = await response.transform(Utf8Decoder()).join();
    Map jsonObject = jsonDecode(stringData);

    login = LoginModel.fromMap(json: jsonObject);
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
                          '   Forgot\n Password',
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
                          '   Enter your email to reset your\n               password',
                          style: kBodyText,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AuthTextInput(
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Choose Another Method",
                                    style: kDonthaveAccountText,
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Need Help?',
                                      style: kCreateText,
                                    ),
                                    onPressed: () {
                                      Get.toNamed('/register');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: TextButton(
                              onPressed: () {
// verify code logic here
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered))
                                    return Colors.green;
                                  return Colors.purpleAccent;
                                }),
                              ),
                              child: const Text(
                                'Send Code',
                                style: kLoginButtonText,
                              ),
                            ),
                          ),
                        ]))
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
