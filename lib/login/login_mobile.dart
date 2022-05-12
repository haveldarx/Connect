import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/coustom_widgets/form.dart';
import 'package:connect/login/login_screen.dart';
import 'package:connect/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Utils/AppColors.dart';
import '../Utils/SizeConfig.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// To be done:
// 1) Implement country code picker (for now just put 10 countries) - Done
// 2) Dont allow button functionality if rules are violated - Done
// 3) Implement resend otp - Ui done functionality need to be added
// 4) Otp design boxes - Done

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  final formKeyMobile = GlobalKey<FormState>();
  final formKeyOTP = GlobalKey<FormState>();
  String verificationId = '';
  var _isClicked = false;
  var showLoading = false;

  Widget showOtpBox({var onpressed}) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          'Phone Number Verification',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
        child: RichText(
          text: TextSpan(
              text: "Enter the code sent to ",
              children: [
                TextSpan(
                    text: _mobileController.text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              ],
              style: const TextStyle(color: Colors.black54, fontSize: 15)),
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      PinCodeTextField(
        appContext: context,
        length: 6,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          activeColor: Color.fromRGBO(141, 242, 242, 1),
          selectedColor: Colors.red,
          selectedFillColor: Colors.white,
          inactiveColor: Color.fromRGBO(174, 178, 242, 1),
          inactiveFillColor: Colors.white,
        ),
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
        // errorAnimationController: errorController,
        // controller: textEditingController,
        onCompleted: (v) {
          print("Completed");
        },
        onChanged: (value) {
          print(value);
          setState(() {
            // currentText = value;
          });
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Didn't receive the code? ",
            style: TextStyle(color: Colors.black54, fontSize: 15),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Resend",
              style: TextStyle(
                  color: Color.fromRGBO(174, 178, 242, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )
        ],
      ),
      MaterialButton(
        onPressed: onpressed,
        child: Container(
            height: SizeConfig.blockSizeVertical * 6,
            constraints: BoxConstraints(minWidth: double.infinity),
            child: Center(
                child: Text(
              'Verify OTP',
              style: TextStyle(
                color: Colors.white,
              ),
            ))),
        color: Theme.of(context).primaryColor,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? currentUser;
    String uid = '';
    final db = FirebaseFirestore.instance;

    void signInWithPhoneAuthCredential(
        PhoneAuthCredential phoneAuthCredential) async {
      setState(() {
        showLoading = true;
      });

      try {
        final authCredential =
            await _auth.signInWithCredential(phoneAuthCredential);
        currentUser = authCredential.user;
        uid = (_auth.currentUser)!.uid;
        setState(() {
          showLoading = false;

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        });

        // var doc = await db.collection('users').doc(currentUser!.uid).get();

      } on FirebaseAuthException catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Enter correct OTP"),
          ),
        );
        setState(() {
          showLoading = false;
        });
      }
    }

    MobileVerificationState currentState =
        MobileVerificationState.SHOW_MOBILE_FORM_STATE;
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
                    child: _isClicked
                        ? showOtpBox(
                            onpressed: () {
                              setState(() {
                                _isClicked = true;
                              });
                              PhoneAuthCredential phoneAuthCredential =
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationId,
                                      smsCode: _otpController.text);

                              signInWithPhoneAuthCredential(
                                  phoneAuthCredential);
                            },
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Column(
                                  children: [
                                    IntlPhoneField(
                                      initialCountryCode: 'IN',
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        labelText: 'Phone Number',
                                      ),
                                      onChanged: (phone) {
                                        print(phone.completeNumber);
                                        _mobileController.text =
                                            phone.completeNumber;
                                      },
                                      onCountryChanged: (country) {
                                        print('Country changed to: ' +
                                            country.name);
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.blockSizeHorizontal *
                                                  15,
                                          vertical:
                                              SizeConfig.blockSizeVertical * 4),
                                      child: Material(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100.0)),
                                        clipBehavior: Clip.antiAlias,
                                        child: MaterialButton(
                                          onPressed: () async {
                                            setState(() {
                                              _isClicked = true;
                                            });
                                            setState(() {
                                              showLoading = true;
                                            });

                                            await _auth.verifyPhoneNumber(
                                              phoneNumber:
                                                  _mobileController.text,
                                              verificationCompleted:
                                                  (phoneAuthCredential) async {
                                                setState(() {
                                                  showLoading = false;
                                                });
                                                signInWithPhoneAuthCredential(
                                                    phoneAuthCredential);
                                              },
                                              verificationFailed:
                                                  (verificationFailed) async {
                                                setState(() {
                                                  showLoading = false;
                                                });
                                                // _scaffoldKey.currentState.showSnackBar(
                                                // SnackBar(content: Text(verificationFailed.message)));
                                              },
                                              codeSent: (verificationId,
                                                  resendingToken) async {
                                                setState(() {
                                                  showLoading = false;
                                                  currentState =
                                                      MobileVerificationState
                                                          .SHOW_OTP_FORM_STATE;
                                                  this.verificationId =
                                                      verificationId;
                                                });
                                              },
                                              codeAutoRetrievalTimeout:
                                                  (verificationId) async {},
                                            );
                                          },
                                          child: Container(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      6,
                                              constraints: BoxConstraints(
                                                  minWidth: double.infinity),
                                              child: Center(
                                                  child: Text(
                                                'Send OTP',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ))),
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
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
