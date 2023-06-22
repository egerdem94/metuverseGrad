import 'package:flutter/material.dart';
import 'package:metuverse/navigation/Navigate.dart';
import 'package:metuverse/palette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metuverse/screens/auth_screens/forgot_password/controller/ForgotPasswordBackend.dart';
import 'package:metuverse/screens/auth_screens/widgets/AuthTextInput.dart';
import 'package:metuverse/widgets/background-image.dart';

class ForgotPasswordCheckVerification extends StatefulWidget {
  final String email;
  const ForgotPasswordCheckVerification({Key? key, required this.email}) : super(key: key);

  @override
  _ForgotPasswordCheckVerificationState createState() => _ForgotPasswordCheckVerificationState();
}

class _ForgotPasswordCheckVerificationState extends State<ForgotPasswordCheckVerification> {
  TextEditingController verificationCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ForgotPasswordBackend forgotPasswordBackend = ForgotPasswordBackend();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    verificationCodeController.dispose();
    passwordController.dispose();
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          '   Verify\n Code',
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
                          '   Enter your verification code and\n new password',
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
                              AuthTextInput(
                                icon: FontAwesomeIcons.key,
                                hint: 'Verification Code',
                                inputType: TextInputType.text,
                                inputAction: TextInputAction.next,
                                passwordObscured: false,
                                enterInfo: verificationCodeController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              AuthTextInput(
                                icon: FontAwesomeIcons.lock,
                                hint: 'New Password',
                                inputType: TextInputType.visiblePassword,
                                inputAction: TextInputAction.done,
                                passwordObscured: true,
                                enterInfo: passwordController,
                              ),
                              SizedBox(
                                height: 20,
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
                              onPressed: () async {
                                var response = await forgotPasswordBackend.checkVerificationCode(widget.email, passwordController.text, verificationCodeController.text);
                                if(response){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Password updated successfully'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  MyNavigation.navigateToLogin(context);
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please check your verification code, and try again.'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
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
                                'Reset Password',
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
