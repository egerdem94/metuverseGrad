
import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:metuverse/auth/screens/forgotPassword.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/widgets/background-image.dart';
/*
class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class VerificationBox extends StatelessWidget {
  final TextEditingController enterInfo;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final FocusNode previousFocusNode;
  final someFocusNode = FocusNode();

  VerificationBox({
    required this.enterInfo,
    required this.focusNode,
    required this.nextFocusNode,
    required this.previousFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: TextField(
        keyboardType: TextInputType.number,
        controller: enterInfo,
        focusNode: focusNode,
        textInputAction: TextInputAction.done,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 1,
        onChanged: (value) {
          if (value.length == 1) {
            focusNode.unfocus();
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
          } else if (value.isEmpty) {
            focusNode.unfocus();
            if (previousFocusNode != null) {
              FocusScope.of(context).requestFocus(previousFocusNode);
            }
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _VerificationPageState extends State<VerificationPage> {
  final emailVerificationCode1 = TextEditingController();
  final emailVerificationCode1Focus = FocusNode();
  final emailVerificationCode2 = TextEditingController();
  final emailVerificationCode2Focus = FocusNode();
  final emailVerificationCode3 = TextEditingController();
  final emailVerificationCode3Focus = FocusNode();
  final emailVerificationCode4 = TextEditingController();
  final emailVerificationCode4Focus = FocusNode();
  final emailVerificationCode5 = TextEditingController();
  final emailVerificationCode5Focus = FocusNode();
  final emailVerificationCode6 = TextEditingController();
  final emailVerificationCode6Focus = FocusNode();
  final mobileVerificationCode1 = TextEditingController();
  final mobileVerificationCode1Focus = FocusNode();
  final mobileVerificationCode2 = TextEditingController();
  final mobileVerificationCode2Focus = FocusNode();
  final mobileVerificationCode3 = TextEditingController();
  final mobileVerificationCode3Focus = FocusNode();
  final mobileVerificationCode4 = TextEditingController();
  final mobileVerificationCode4Focus = FocusNode();
  final mobileVerificationCode5 = TextEditingController();
  final mobileVerificationCode5Focus = FocusNode();
  final mobileVerificationCode6 = TextEditingController();
  final mobileVerificationCode6Focus = FocusNode();

  LoginModel? login;
  bool passwordVisibilityBool = true;

  void _loginServiceGet() async {
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
            backgroundColor: Color.fromARGB(0, 0, 0, 0),
            body: SafeArea(
              child: SingleChildScrollView(
                // bottom overflowed (keyboard) error
                child: Column(
                  children: [
                    SizedBox(
                      height: 240,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Verify',
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
                          'Messenger has sent a code to verify your account',
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email Verification:',
                                style: kBodyText,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  VerificationBox(
                                    enterInfo: emailVerificationCode1,
                                    focusNode: emailVerificationCode1Focus,
                                    nextFocusNode: emailVerificationCode2Focus,
                                    previousFocusNode: FocusNode(),
                                  ),
                                  VerificationBox(
                                    enterInfo: emailVerificationCode2,
                                    focusNode: emailVerificationCode2Focus,
                                    nextFocusNode: emailVerificationCode3Focus,
                                    previousFocusNode:
                                        emailVerificationCode1Focus,
                                  ),
                                  VerificationBox(
                                    enterInfo: emailVerificationCode3,
                                    focusNode: emailVerificationCode3Focus,
                                    nextFocusNode: emailVerificationCode4Focus,
                                    previousFocusNode:
                                        emailVerificationCode2Focus,
                                  ),
                                  VerificationBox(
                                    enterInfo: emailVerificationCode4,
                                    focusNode: emailVerificationCode4Focus,
                                    nextFocusNode: emailVerificationCode5Focus,
                                    previousFocusNode:
                                        emailVerificationCode3Focus,
                                  ),
                                  VerificationBox(
                                    enterInfo: emailVerificationCode5,
                                    focusNode: emailVerificationCode5Focus,
                                    nextFocusNode: emailVerificationCode6Focus,
                                    previousFocusNode:
                                        emailVerificationCode4Focus,
                                  ),
                                  VerificationBox(
                                    enterInfo: emailVerificationCode6,
                                    focusNode: emailVerificationCode6Focus,
                                    previousFocusNode:
                                        emailVerificationCode5Focus,
                                    nextFocusNode: FocusNode(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Mobile Verification:',
                                style: kBodyText,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  VerificationBox(
                                    enterInfo: mobileVerificationCode1,
                                    focusNode: mobileVerificationCode1Focus,
                                    nextFocusNode: mobileVerificationCode2Focus,
                                    previousFocusNode: FocusNode(),
                                  ),
                                  VerificationBox(
                                    enterInfo: mobileVerificationCode2,
                                    focusNode: mobileVerificationCode2Focus,
                                    nextFocusNode: mobileVerificationCode3Focus,
                                    previousFocusNode:
                                        mobileVerificationCode1Focus,
                                  ),
                                  VerificationBox(
                                    enterInfo: mobileVerificationCode3,
                                    focusNode: mobileVerificationCode3Focus,
                                    nextFocusNode: mobileVerificationCode4Focus,
                                    previousFocusNode:
                                        mobileVerificationCode2Focus,
                                  ),
                                  VerificationBox(
                                    enterInfo: mobileVerificationCode4,
                                    focusNode: mobileVerificationCode4Focus,
                                    nextFocusNode: mobileVerificationCode5Focus,
                                    previousFocusNode:
                                        mobileVerificationCode3Focus,
                                  ),
                                  VerificationBox(
                                    enterInfo: mobileVerificationCode5,
                                    focusNode: mobileVerificationCode5Focus,
                                    nextFocusNode: mobileVerificationCode6Focus,
                                    previousFocusNode:
                                        mobileVerificationCode4Focus,
                                  ),
                                  VerificationBox(
                                    enterInfo: mobileVerificationCode6,
                                    focusNode: mobileVerificationCode6Focus,
                                    previousFocusNode:
                                        mobileVerificationCode5Focus,
                                    nextFocusNode: FocusNode(),
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
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.hovered))
                                        return Colors.green;
                                      return Colors.purpleAccent;
                                    }),
                                  ),
                                  child: const Text(
                                    'Verify',
                                    style: kLoginButtonText,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Center(
                                  child:
                                      Text('Resend Code', style: kCreateText),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
*/
