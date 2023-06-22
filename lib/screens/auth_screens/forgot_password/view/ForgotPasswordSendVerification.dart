import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metuverse/screens/auth_screens/forgot_password/controller/ForgotPasswordBackend.dart';
import 'package:metuverse/screens/auth_screens/forgot_password/view/ForgotPasswordCheckVerification.dart';
import 'package:metuverse/screens/auth_screens/widgets/AuthTextInput.dart';
import 'package:metuverse/widgets/background-image.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);
  //"message": "Your verification code has been sent."
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController email = TextEditingController();
  ForgotPasswordBackend forgotPasswordBackend = ForgotPasswordBackend();
  void dispose() {
    // Clean up the controller when the widget is disposed.
    email.dispose();
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
                      height: 30,
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
                                var response = await forgotPasswordBackend.sendVerificationCode(email.text);
                                if(response){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ForgotPasswordCheckVerification(email: email.text)),
                                  );
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please check your email and try again.'),
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
