import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/Utils/SizeConfig.dart';
import 'package:connect/coustom_widgets/form.dart';
import 'package:connect/login/login_mobile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Utils/AppColors.dart';
import '../Utils/UserData.dart';
import '../screens/home_screen.dart';
import 'auth_loading_screen.dart';
import 'login_screen.dart';

//To be done:
// 1) Fix Overflow
// 2) Create date of birth picker (calendar option) , manually type it should
//    add / ex: when i type 06102001 it should be shown as 06/10/2001
// 3) Make sure there are rules and validation for email and password deatails;
//    such as password length (firebase min 6), email format, confirm password should be same
// 4) dont allow button to work if rules are violated
// 5) Remember me funcitonality

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
   final FirebaseAuth _auth = FirebaseAuth.instance;
   User? user = FirebaseAuth.instance.currentUser;
   final firestoreInstance = FirebaseFirestore.instance;
   final GoogleSignIn googleSignIn = GoogleSignIn();

   UserData userData = UserData();

   late String email;
   late String password;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _DOBController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: CustomPaint(
        painter: MyPainter(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 5,
              vertical: SizeConfig.blockSizeVertical * 5),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 5),
                child: Text(
                  " Connect",
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 10,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
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
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
              Card(
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
                        formfield(text: 'Email', controller: _emailController),
                        formfield(
                            text: 'Password', controller: _passwordController),
                        formfield(
                            text: 'Confirm Password', controller: _confirmPasswordController),
                        formfield(
                            text: 'Date of Birth', controller: _DOBController, ),
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
                                email = _emailController.text;
                                if(_passwordController.text == _confirmPasswordController.text){        // ToDO: 1)
                                  password = _passwordController.text;
                                }
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                      email: email, password: password);
                                } catch (e) {
                                 // if (e.code == 'weak-password') {
                                 //   print('The password provided is too weak.');
                                 // } else if (e.code == 'email-already-in-use') {
                                 //   print('The account already exists for that email.');
                                 // }
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AuthLoadingScreen(
                                          email: email, password: password,),
                                    ));
                              },
                              child: Container(
                                  height: SizeConfig.blockSizeVertical * 6,
                                  constraints:
                                      BoxConstraints(minWidth: double.infinity),
                                  child: Center(
                                      child: Text(
                                    'Sign Up ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2),
                                  ))),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: SizeConfig.blockSizeVertical * 15,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                      SizeConfig.blockSizeVertical * 2),
                                  child: Divider(
                                    height: SizeConfig.blockSizeVertical * 3,
                                    color: Colors.black,
                                  ),
                                )),
                            Text(
                              'OR',
                              style: TextStyle(),
                            ),
                            SizedBox(
                                width: SizeConfig.blockSizeVertical * 15,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                      SizeConfig.blockSizeVertical * 2),
                                  child: Divider(
                                    height: SizeConfig.blockSizeVertical * 3,
                                    color: Colors.black,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                  SizeConfig.blockSizeHorizontal * 3,
                                  vertical: SizeConfig.blockSizeVertical * 4),
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0)),
                                clipBehavior: Clip.antiAlias,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MobileScreen(),
                                        ));
                                  },
                                  child: SizedBox(
                                    height: SizeConfig.blockSizeVertical * 6,
                                    //constraints: BoxConstraints(minWidth: double.infinity),
                                    child: Image(
                                      image: AssetImage(
                                          "Assets/Logos/MobileIcon.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                  SizeConfig.blockSizeHorizontal * 3,
                                  vertical: SizeConfig.blockSizeVertical * 4),
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0)),
                                clipBehavior: Clip.antiAlias,
                                child: MaterialButton(
                                  onPressed: () {
                                    signInWithGoogle().whenComplete(() {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen(),
                                          ));
                                    });
                                  },
                                  child: SizedBox(
                                    height: SizeConfig.blockSizeVertical * 6,
                                    //constraints: BoxConstraints(minWidth: double.infinity),
                                    child: Image(
                                      image: AssetImage(
                                          "Assets/Logos/GoogleLogo.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 1.5,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.all(SizeConfig.blockSizeVertical),
                            child: Text(
                              'Log in here',
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2,
                                color: AppColors.complimentColor,
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

   Future<String> signInWithGoogle() async {
     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
     final GoogleSignInAuthentication? googleSignInAuthentication =
     await googleSignInAccount?.authentication;

     final AuthCredential credential = GoogleAuthProvider.credential(
       accessToken: googleSignInAuthentication?.accessToken,
       idToken: googleSignInAuthentication?.idToken,
     );

     final UserCredential userCredential =
     await _auth.signInWithCredential(credential);
     final User? user = userCredential.user;

     assert(!user!.isAnonymous);
     assert(await user?.getIdToken() != null);

     final User? currentUser = _auth.currentUser;
     assert(user?.uid == currentUser?.uid);

     return 'signInWithGoogle succeeded: $user';
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
