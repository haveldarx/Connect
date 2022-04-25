import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/coustom_widgets/form.dart';
import 'package:connect/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}
class MobileScreen extends StatefulWidget {
  const MobileScreen({ Key? key }) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  String verificationId = '';
  var _isClicked = false;
  var showLoading = false;
  Widget showOtpBox({var onpressed}){
    return Column(children:[
        formfield(text: 'Enter OTP', controller: _otpController,),
                    Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
             onPressed: onpressed,
              
              child: Container(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: Center(
                 child: Text(
                      'Verify OTP',
                          style: TextStyle(color: Colors.white,),
                        ))),
                  color: Theme.of(context).primaryColor,
            ),
          ),
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
        appBar: AppBar(
          title: Center(child: Text('Login')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            formfield(text: 'Mobile', controller: _mobileController),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () async{
                  setState(() {
                    _isClicked = true;
                  });
                   setState(() {
                showLoading = true;
              });

              await _auth.verifyPhoneNumber(
                phoneNumber: _mobileController.text,
                verificationCompleted: (phoneAuthCredential) async {
                  setState(() {
                    showLoading = false;
                  });
                  signInWithPhoneAuthCredential(phoneAuthCredential);
                },
                verificationFailed: (verificationFailed) async {
                  setState(() {
                    showLoading = false;
                  });
                  // _scaffoldKey.currentState.showSnackBar(
                  // SnackBar(content: Text(verificationFailed.message)));
                },
                codeSent: (verificationId, resendingToken) async {
                  setState(() {
                    showLoading = false;
                    currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                   this.verificationId = verificationId;
                  });
                },
                codeAutoRetrievalTimeout: (verificationId) async {},
              );
                  
                },
                
                child: Container(
                constraints: BoxConstraints(minWidth: double.infinity),
                child: Center(
                   child: Text(
                        'Send OTP',
                            style: TextStyle(color: Colors.white,),
                          ))),
                    color: Theme.of(context).primaryColor,
              ),
            ),
            _isClicked ? showOtpBox( onpressed: () {
                setState(() {
                  _isClicked = true;
                });
                PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: _otpController.text);

              signInWithPhoneAuthCredential(phoneAuthCredential);
                
              },) : Container(),
          ]),
        ),
      ),
    );
  }
}