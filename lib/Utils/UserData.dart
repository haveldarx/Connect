import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return [
      prefs.getString('uid'),
      prefs.getString('country'),
      prefs.getString('locality'),
      prefs.getString('email'),
      prefs.getString('phone'),
      prefs.getString('date of birth')
    ];
  }

  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  setUid(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', value);
  }

  getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('country');
  }

  setCountry(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('country', value);
  }

  getLocality() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('locality');
  }

  setLocality(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('locality', value);
  }

  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  setEmail(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', value);
  }

  getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone');
  }

  setPhone(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone', value);
  }

  setRememberMeEmail(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('rememberMeEmail', value);
  }

  setRememberMePassword(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('rememberMePassword', value);
  }

  getRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return [
      prefs.getString('rememberMeEmail'),
      prefs.getString('rememberMePassword')
    ];
  }

  getDOB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('date of birth');
  }

  setDOB(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('date of birth', value);
  }
}
