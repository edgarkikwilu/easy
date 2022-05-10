import 'dart:async';

import 'package:easy_client/Auth/login.dart';
import 'package:easy_client/Helper/helper.dart';
import 'package:easy_client/controllers/AuthController.dart';
import 'package:easy_client/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState(){
    _timer = Timer(const Duration(milliseconds: 4000), () {
      bool isAuth = _authController.getIsAuth();
      if(isAuth){
        Get.to(()=>Home());
      }else{
        Get.to(()=>const LoginWidget());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Helper.getScreenWidth(context),
        height: Helper.getScreenHeight(context),
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              // child: Image.asset(
              //   Helper.getAssetName("splashIcon.png", "virtual"),
              //   fit: BoxFit.fill,
              // ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                Helper.getAssetName("car_with_transparent_logo.jpg", "brand"),
                width: MediaQuery.of(context).size.width-40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
