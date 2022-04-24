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
      title: 'Connect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        'WelcomeScreen' : (context) => const WelcomeScreen(),
      },
      initialRoute: 'WelcomeScreen',
    );
  }
}
