import 'package:connect/Utils/AppColors.dart';
import 'package:connect/login/login_mobile.dart';
import 'package:connect/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Welcome Screens/WelcomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connect',
      theme: ThemeData(
        primaryColor: AppColors.complimentColor,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        'WelcomeScreen' : (context) =>  WelcomeScreen(),
        'LoginScreen' : (context) =>  LoginScreen(),
        // 'MobileScreen' : (context) =>  MobileScreen(),
      },
      initialRoute: 'WelcomeScreen',
    );
  }
}
