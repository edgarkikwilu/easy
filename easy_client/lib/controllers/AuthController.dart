import 'dart:convert';

import 'package:easy_client/Helper/colors.dart';
import 'package:easy_client/Helper/helper.dart';
import 'package:easy_client/home.dart';
import 'package:easy_client/home.dart';
import 'package:easy_client/home_tab/Landing.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController{
  TextEditingController nameController = TextEditingController(text: "Edgar");
  TextEditingController phoneNumberController = TextEditingController(text: "0656724750");
  TextEditingController otpController = TextEditingController(text:"123456");

  late SharedPreferences sharedPreferences;

  bool _codeSent = false;
  bool _isLoading = false;
  bool hasAccount = true;
  String _verificationId = "";
  String firebaseIdToken = "";
  late FirebaseAuth firebaseAuth;

  @override
  onInit() async{
    super.onInit();
    firebaseAuth = FirebaseAuth.instance;
    sharedPreferences = await SharedPreferences.getInstance();
  }

  bool getCodeSent() => _codeSent;
  bool getIsLoading() => _isLoading;

  setCodeSent(bool codeSent){
    _codeSent = codeSent;
    update(['login-screen','register-screen']);
  }

  setIsLoading(bool isLoading){
    _isLoading = isLoading;
    update(['login-screen','register-screen']);
  }

  bool getIsAuth() => sharedPreferences.getBool("isAuth")??false;

  sendOtp(BuildContext context) async{
    setIsLoading(true);
    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+255${phoneNumberController.text.substring(phoneNumberController.text.length - 9)}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("******Verification completed*********");
          firebaseAuth.signInWithCredential(credential).then((response){
            var user = firebaseAuth.currentUser;
            user!.getIdToken().then((value){
              firebaseIdToken = value;
              if(hasAccount){
                _login(value,context);
              }else{
                _register(value,context);
              }
            }).catchError((onError){
              print(onError);
            });
          }).catchError((onError){
            print(onError);
          });
        },
        verificationFailed: (FirebaseAuthException e){
          print("******Auto Verification failed*********");

          setIsLoading(false);
          if(e.code == 'invalid-phone-number'){
            print('invalid phone number');
            edgeAlert(context,title: "Error!",description: "Invalid phone number entered",backgroundColor: AppColor.orange,
                icon: Icons.error_outline_outlined, gravity: Gravity.top,duration: 3);
          }else if(e.code == 'too-many-requests'){
            print('too-many-requests');
            edgeAlert(context,title: "Oops!",description: "You have reached maximum attempts. Please wait for an hour!",backgroundColor: AppColor.orange,
                icon: Icons.check_circle_outline_outlined, gravity: Gravity.top,duration: 5);
          }else{
            edgeAlert(context,title: "Oops!",description: "Third party connection error!",backgroundColor: AppColor.orange,
                icon: Icons.check_circle_outline_outlined, gravity: Gravity.top,duration: 5);
            print("Firebase phone number verification error");
            print(e);
            print(e.message);
            print(e.stackTrace);
          }
        },
        codeSent: (String? verificationId, int? resendToken)async{
          print("******Code Sent*********");
          setCodeSent(true);
          setIsLoading(false);
          _verificationId = verificationId!;
          edgeAlert(context,title: "Success!",description: "Verification code has been sent to ${phoneNumberController.text}",backgroundColor: AppColor.orange,
              icon: Icons.error_outline_outlined, gravity: Gravity.top,duration: 3);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("******Auto Retrieval Timeout*********");
          // setIsLoading(false);
        }
    );
  }

  verifyOtp(BuildContext context) async{
    setIsLoading(true);
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: otpController.text);
    await firebaseAuth.signInWithCredential(phoneAuthCredential).then((value){
      var user = value.user;

      user!.getIdToken().then((value){
        firebaseIdToken = value;
        print('user.getidtoken');
        print(firebaseIdToken);
        if(hasAccount){
          _login(value,context);
        }else{
          _register(value,context);
        }
      }).catchError((onError){
        setIsLoading(false);
        print(onError);
      });
    }).catchError((onError){
      setIsLoading(false);
      print(onError);
    });
  }

  _login(String firebaseIdToken,BuildContext context) async{
    print('login');
    var response = await http.post(Helper.parseUrl("customer/login"),
        headers: <String,String>{
          "Accept":"application/json",
          "Content-Type":"application/json",
          "firebaseIdToken":firebaseIdToken
        },
        body: jsonEncode(<String,String>{
          "phoneNumber":"255${phoneNumberController.text.substring(phoneNumberController.text.length-9)}",
          "usertype":"landlord"
        })
    );
    setIsLoading(false);
    print('login response');
    print(response.statusCode);
    print(response.body);

    setCodeSent(false);

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      String accessToken = data['token'];
      print("ACCESS_TOKEN: "+accessToken);
      sharedPreferences.setString("accessToken", accessToken);
      sharedPreferences.setBool("isAuth", true);
      edgeAlert(context,title: "Success!",description: "You have successfully logged in",backgroundColor: AppColor.primary,
          icon: Icons.check_circle_outlined, gravity: Gravity.top,duration: 3);
      hasAccount = true;
      Get.to(()=>const Home());
    }else if(response.statusCode == 401){
      // registerDialog(context);
      hasAccount = false;
      // Get.to(()=>SignUpScreen());
      edgeAlert(context,title: "Oops!",description: "Account not found",backgroundColor: AppColor.orange,
          icon: Icons.error_outline_outlined, gravity: Gravity.top,duration: 3);
    }else if(response.statusCode == 404){
      // registerDialog(context);
      hasAccount = false;
      // Get.to(()=>SignUpScreen());
      edgeAlert(context,title: "Oops!",description: "Account not registered",backgroundColor: AppColor.orange,
          icon: Icons.error_outline_outlined, gravity: Gravity.top,duration: 3);
    } else if(response.statusCode == 402){
      print(response.statusCode);
      print(response.body);
      edgeAlert(context,title: "Oops!",description: "Account not found",backgroundColor: AppColor.orange,
          icon: Icons.error_outline_outlined, gravity: Gravity.top,duration: 3);
    }else{
      print(response.body);
      print(response.statusCode);
      edgeAlert(context,title: "Oops!",description: "Internal server error. Please try again!",backgroundColor: AppColor.orange,
          icon: Icons.error_outline_outlined, gravity: Gravity.top,duration: 3);
    }
  }

  _register(String token, BuildContext context) async{
    var body = jsonEncode(<String,dynamic>{
      "username": nameController.text,
      "phoneNumber":phoneNumberController.text,
      "firebaseToken":token
    });
    var response = await http.post(Helper.parseUrl('customer/register'),headers: Helper.getHeaders(), body: body);

    setIsLoading(false);
    print(response.body);

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      sharedPreferences.setString("accessToken", data['token']);
      sharedPreferences.setString("username", data['user']['name']);
      sharedPreferences.setBool("isAuth", true);
      edgeAlert(context,title: "Success!",description: "You have successfully logged in",backgroundColor: AppColor.primary,
          icon: Icons.check_circle_outlined, gravity: Gravity.top,duration: 3);
      hasAccount = true;
      Get.to(()=>const Home());
    }else if(response.statusCode == 401){
      // registerDialog(context);
      hasAccount = false;
      edgeAlert(context,title: "Oops!",description: "Account not found",backgroundColor: AppColor.orange,
          icon: Icons.error_outline_outlined, gravity: Gravity.top,duration: 3);
      // Get.to(()=>SignUpScreen());
    }else if(response.statusCode == 402){
      print(response.statusCode);
      print(response.body);
      edgeAlert(context,title: "Oops!",description: "Account not found",backgroundColor: AppColor.orange,
          icon: Icons.error_outline_outlined, gravity: Gravity.top,duration: 3);
    }else{
      print(response.body);
      print(response.statusCode);
      edgeAlert(context,title: "Oops!",description: "Internal server error. Please try again!",backgroundColor: AppColor.orange,
          icon: Icons.error_outline_outlined, gravity: Gravity.top,duration: 3);
    }

  }

  Future<int> logout() async{
    this.sharedPreferences.setBool("isAuth", false);
    this.sharedPreferences.setString("accessToken", "");
    return 0;
  }
}