

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/database/models/user_model.dart';

class UserDatabase {
  final db = FirebaseFirestore.instance;
  

  Future createUser(UserModel user) async {
    String retVal = 'error';
    try {
      await db.collection('users').doc(user.id).set({
        'name': user.name,
        'email': user.email,
        'phone': user.phone,
        'defaultAddressId': user.defaultAddressId,
        'defaultVehicleId': user.defaultVehicleId,
        'id': user.id,
        'profileImageUrl': user.profileImageUrl,
        'timestamp': user.timestamp,
      });
      retVal = "Success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}