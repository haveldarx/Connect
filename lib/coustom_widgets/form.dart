import 'package:flutter/material.dart';


Widget formfield({var text, var controller}) {
  return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        width: double.infinity,
        child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: '$text',
              hintStyle: TextStyle(
                  
                  color: Color.fromARGB(255, 154, 154, 154)),
            )),
      ));
}