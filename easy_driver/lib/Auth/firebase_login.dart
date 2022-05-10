import 'package:easy_driver/Auth/signUpScreen.dart';
import 'package:easy_driver/Helper/CustomTheme.dart';
import 'package:easy_driver/Helper/helper.dart';
import 'package:easy_driver/controllers/AuthController.dart';
import 'package:easy_driver/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FirebaseLogin extends StatelessWidget {
  static const routeName = "/loginScreen";

  const FirebaseLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      id: 'login-screen',
      builder:(controller)=> Scaffold(
        body: SizedBox(
          height: Helper.getScreenHeight(context),
          width: Helper.getScreenWidth(context),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 30,
              ),
              child: Column(
                children: [
                  Text(
                    "Login",
                    style: Helper.getTheme(context).headline6,
                  ),
                  const Spacer(),
                  const Text('Add your details to login'),
                  const Spacer(),
                  Visibility(
                    visible: !controller.getCodeSent(),
                    child: TextFormField(
                      controller: controller.phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Phone Number"
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.getCodeSent(),
                    child: TextFormField(
                      controller: controller.otpController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Otp"
                      ),
                    ),
                  ),
                  const Spacer(),
                  Visibility(
                    visible: !controller.getIsLoading() && !controller.getCodeSent(),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.of(context)
                          //     .pushReplacementNamed(IntroScreen.routeName);
                          controller.hasAccount = true;
                          controller.sendOtp(context);
                        },
                        child: const Text("Login"),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !controller.getIsLoading() && controller.getCodeSent(),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.sharedPreferences.setBool("isAuth", true);
                          Get.off(()=>Home());
                          // controller.verifyOtp(context);
                        },
                        child: const Text("Verify Otp"),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: controller.getIsLoading(),
                      child: CircularProgressIndicator(backgroundColor: CustomColors.white)
                  ),
                  const Spacer(flex: 4),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>const SignUpScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an Account?"),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            color: CustomColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
