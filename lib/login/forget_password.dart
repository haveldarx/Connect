import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connect/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Utils/AppColors.dart';
import '../Utils/SizeConfig.dart';
import '../coustom_widgets/form.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController _emailController = TextEditingController();
  final formKeyEmail = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomPaint(
          painter: MyPainter(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 7),
                    child: Material(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      clipBehavior: Clip.antiAlias,
                      child: SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 13,
                        height: SizeConfig.blockSizeHorizontal *
                            13, // to make perfect circle
                        child: MaterialButton(
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: SizeConfig.blockSizeVertical * 4,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                        ),
                      ),
                    ),
                  ),
                  Text(
                    " Connect",
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 10,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              AnimatedTextKit(repeatForever: true, animatedTexts: [
                TypewriterAnimatedText('Friends',
                    textStyle: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 3,
                    ),
                    speed: Duration(milliseconds: 100)),
                TypewriterAnimatedText('Colleagues',
                    textStyle:
                        TextStyle(fontSize: SizeConfig.blockSizeVertical * 3),
                    speed: Duration(milliseconds: 100)),
                TypewriterAnimatedText('Mentors',
                    textStyle:
                        TextStyle(fontSize: SizeConfig.blockSizeVertical * 3),
                    speed: Duration(milliseconds: 100)),
                TypewriterAnimatedText('Relationships',
                    textStyle:
                        TextStyle(fontSize: SizeConfig.blockSizeVertical * 3),
                    speed: Duration(milliseconds: 100)),
              ]),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 5,
                    vertical: SizeConfig.blockSizeVertical * 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0)),
                  elevation: 15,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 8,
                        vertical: SizeConfig.blockSizeVertical * 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Reset Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          formfield(formKeyEmail,
                              text: 'Email', controller: _emailController),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeHorizontal * 15,
                                vertical: SizeConfig.blockSizeVertical * 4),
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0)),
                              clipBehavior: Clip.antiAlias,
                              child: MaterialButton(
                                onPressed: () async {
                                  final isValidEmail =
                                      formKeyEmail.currentState!.validate();
                                  if (isValidEmail) {
                                    // showDialog(
                                    //     context: context,
                                    //     barrierDismissible: false,
                                    //     builder: (context) => Center(
                                    //           child:
                                    //               CircularProgressIndicator(),
                                    //         ));
                                    try {
                                      await FirebaseAuth.instance
                                          .sendPasswordResetEmail(
                                              email:
                                                  _emailController.text.trim());
                                      print('Email was sent');
                                    } on FirebaseAuthException catch (e) {
                                      print(e);
                                    }
                                  }
                                },
                                child: Container(
                                    height: SizeConfig.blockSizeVertical * 6,
                                    constraints: BoxConstraints(
                                        minWidth: double.infinity),
                                    child: Center(
                                        child: Text(
                                      'Reset',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ))),
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pathUpper = Path()
      ..moveTo(0, 0)
      ..lineTo(SizeConfig.screenWidth, 0)
      ..quadraticBezierTo(SizeConfig.screenWidth * 1.05,
          SizeConfig.screenHeight * 0.5, 0, SizeConfig.screenWidth);

    final pathLower = Path()
      ..moveTo(SizeConfig.screenWidth, SizeConfig.screenHeight)
      ..lineTo(0, SizeConfig.screenHeight)
      ..quadraticBezierTo(
          SizeConfig.screenWidth * 0.05,
          SizeConfig.screenHeight * 0.5,
          SizeConfig.screenWidth,
          SizeConfig.screenWidth);

    final paintUpper = Paint()..color = AppColors.socialColor;
    final paintLower = Paint()..color = AppColors.workspaceColor;
    canvas.drawPath(pathUpper, paintUpper);
    canvas.drawPath(pathLower, paintLower);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
