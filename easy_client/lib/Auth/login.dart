import 'package:easy_client/Auth/firebase_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginWidget extends StatefulWidget{
  const LoginWidget({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}
class LoginState extends State<LoginWidget>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand,
        children: [
          Image.asset("assets/brand/car_with_round_logo.jpg",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth),
          Positioned(
            bottom: 60,
            left: 10,
            right: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButtonTheme.of(context).style,
                onPressed: (){
                  Get.to(()=>const FirebaseLogin());
                },
                  child: const Text("Login with mobile number")
              ),
            )
          ),
          Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: TextButton(
                    onPressed: (){
                      Get.to(()=>const FirebaseLogin());
                    },
                    child: const Text("Don't have an account? Register here")
                ),
              )
          )
        ],
      ),
    );
  }
}