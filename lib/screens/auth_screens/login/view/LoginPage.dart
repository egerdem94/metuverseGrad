import 'package:flutter/material.dart';
import 'package:metuverse/screens/auth_screens/forgot_password/view/ForgotPasswordSendVerification.dart';
import 'package:metuverse/screens/auth_screens/widgets/AuthTextInput.dart';
import 'package:metuverse/screens/auth_screens/login/controller/storage/backend/LoginBackend.dart';
import 'package:metuverse/screens/auth_screens/login/model/LoginModelX.dart';
import 'package:metuverse/palette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metuverse/screens/home/screens/HomePage.dart';
import 'package:get/get.dart';
import 'package:metuverse/widgets/background-image.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  LoginBackend loginBackend = LoginBackend();
  bool passwordVisibilityBool = true;
  bool isLoginClicked = false;

  void dispose() {
    // Clean up the controller when the widget is disposed.
    email.dispose();
    password.dispose();
    super.dispose();
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
                        constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
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
                                Stack(
                                  children: [
                                    AuthTextInput(
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
                                    onPressed: () async {
                                      if(isLoginClicked == false){
                                        isLoginClicked = true;
                                        //userLogin();
                                        LoginModelX loginObject = await loginBackend.login(email.text, password.text);
                                        //Timer(Duration(seconds: 2), () {
                                        if (loginObject.loginStatus == true) {
                                          //token = loginObject?.token;
                                          /*insertUserValues(
                                              loginObject?.token ?? '',
                                              loginObject?.fullName ?? '',
                                              loginObject?.profilePicture ?? null);*/

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content:
                                            Text("Welcome to Metuverse ${loginObject.fullName}"),
                                          ));

                                          //Get.to(HomePage());
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => HomePage(
                                                  )));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content:
                                            Text("Incorrect login, please check your entries."),
                                          ));
                                        }
                                        //});
                                      }
                                      isLoginClicked = false;
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
