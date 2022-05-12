import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

String? password = '';
Widget formfield(formKey,
    {var text,
    var controller,
    function,
    IconData? icon,
    iconFunction,
    TextInputType? inputType}) {
  return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        width: double.infinity,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFormField(
            // onChanged: (value) {
            //   if (value.length == 2 || value.length == 5) {
            //     controller.text = controller.text + '/';
            //   }
            // },
            controller: controller,
            keyboardType: inputType,
            decoration: InputDecoration(
                hintText: '$text',
                hintStyle: TextStyle(color: Color.fromARGB(255, 154, 154, 154)),
                suffixIcon:
                    IconButton(icon: Icon(icon), onPressed: iconFunction)),
            validator: (value) {
              if (text == 'Email') {
                if (value != null && !EmailValidator.validate(value)) {
                  return "Please enter a valid email";
                } else {
                  return null;
                }
              } else if (text == 'Password') {
                if (value != null && value.length < 6) {
                  return "Please enter minimum 6 character";
                } else {
                  password = value;
                  return null;
                }
              } else if (text == 'Confirm Password') {
                if (value != null && value != password) {
                  return "Password does not match";
                } else {
                  return null;
                }
              } else if (text == 'Date of Birth') {
                if (value != null && value.length < 6) {
                  return "Please enter minimum 6 character";
                } else {
                  return null;
                }
              }
            },
          ),
        ),
      ));
}
