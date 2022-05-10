import 'package:easy_driver/controllers/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helper {

  // static String baseUrl = "https://easy-api.ankara.co.tz/v1";
  static String baseUrl = "http://18.218.101.248/king";

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static String getAssetName(String fileName, String type) {
    return "assets/$type/$fileName";
  }

  static TextTheme getTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  static getHeaders(){
    AuthController _authController = Get.find();
    return {
      "Accept":"application/json",
      "Content-Type":"application/json",
      "Authorization":"Bearer ${_authController.sharedPreferences.getString('accessToken')}"
    };
  }

  static parseImageUrl(String url){
    print(url);
    return Uri.parse(baseUrl+"/"+url);
  }

  static parseUrl(String url){
    return Uri.parse(baseUrl+"/"+url);
  }
}
