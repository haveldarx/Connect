import 'dart:async';

import 'package:connect/Utils/SizeConfig.dart';
import 'package:connect/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:connect/Utils/AppColors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
   void handleTimeout() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds: milliseconds), handleTimeout);
  @override
  void initState() {
    scheduleTimeout(5000);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: CustomPaint(
            painter: MyPainter(),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(" Connect",
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 10,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  
                ), ),
               
              ],
            ),
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
      ..quadraticBezierTo(
          SizeConfig.screenWidth*1.05,
          SizeConfig.screenHeight*0.5,
          0,
          SizeConfig.screenWidth);

    final pathLower = Path()
      ..moveTo(SizeConfig.screenWidth, SizeConfig.screenHeight)
      ..lineTo(0, SizeConfig.screenHeight)
      ..quadraticBezierTo(
          SizeConfig.screenWidth*0.05,
          SizeConfig.screenHeight*0.5,
          SizeConfig.screenWidth,
          SizeConfig.screenWidth);

    final paintUpper = Paint()..color = AppColors.socialColor;
    final paintLower = Paint()..color = AppColors.workspaceColor;
    canvas.drawPath(pathUpper, paintUpper);
    canvas.drawPath(pathLower,paintLower);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}