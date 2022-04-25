import 'package:connect/Utils/SizeConfig.dart';
import 'package:connect/coustom_widgets/form.dart';
import 'package:connect/login/login_mobile.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            formfield(text: 'Email', controller: _emailController),
            formfield(text: 'Password', controller: _passwordController),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {
                  // Navigator.pushReplacementNamed(context, '/WelcomeScreen');
                },
                
                child: Container(
          constraints: BoxConstraints(minWidth: double.infinity),
          child: Center(
                child: Text(
              'Login ',
              style: TextStyle(color: Colors.white,),
          ))),
    color: Theme.of(context).primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                SizedBox(width: SizeConfig.screenWidth * 0.3,
                height: 1,
                child: Container(color: Colors.grey,),),
                Text('OR', style: TextStyle(
                ),),
                SizedBox(width: SizeConfig.screenWidth * 0.3,
                height: 1,
                child: Container(color: Colors.grey,),),
          ],),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => MobileScreen(),));
                },
                
                child: Container(
                constraints: BoxConstraints(minWidth: double.infinity),
                child: Center(
                   child: Text(
                        'Login using mobile',
                            style: TextStyle(color: Colors.white,),
                          ))),
                    color: Theme.of(context).primaryColor,
              ),
            ),
            ]),
        )
      ),
    );
  }
}