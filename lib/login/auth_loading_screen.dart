import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';

import '../Utils/SizeConfig.dart';
import '../Utils/UserData.dart';
import '../screens/home_screen.dart';

//To be done:
// 1) Instead of button put a CIRCULAR loader (put min loading time)
// 2) Automatic function work as soon as widgets are built (i,e state is created)

class AuthLoadingScreen extends StatefulWidget {
  final String email;
  final String password;

  AuthLoadingScreen({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State<AuthLoadingScreen> createState() => _AuthLoadingScreenState();
}

class _AuthLoadingScreenState extends State<AuthLoadingScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  UserData userData = UserData();

  GeoCode geoCode = GeoCode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  LocationPermission permission;
                  permission = await Geolocator.requestPermission();
                  Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  var addresses = await geoCode.reverseGeocoding(
                      latitude: position.latitude,
                      longitude: position.longitude);

                  user = FirebaseAuth.instance.currentUser;
                  user?.reload();
                  firestoreInstance.collection("Users").doc(user?.uid).set({
                    "name": null,
                    "address": {
                      "uid": user?.uid,
                      "country": addresses.countryName,
                      "locality": addresses.postal,
                    },
                    "age": null,
                    "gender": null,
                    "email": widget.email,
                    "phone": null,
                  });
                  setData(
                    user?.uid,
                    addresses.countryName,
                    addresses.postal,
                    widget.email,
                  );
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                },
                child: Text(
                  'Socialize!',
                  style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  setData(uid, country, locality, email) {
    print(country);
    print(locality);
    userData.setUid(uid);
    userData.setCountry(country);
    userData.setLocality(locality);
    userData.setEmail(email);
    // userData.setPhone(phone);

    // if(checkedValue){
    //   userData.setRememberMeEmail(email);
    //   userData.setRememberMePassword(password);
    // }
  }
}
