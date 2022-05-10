import 'package:easy_driver/Auth/firebase_login.dart';
import 'package:easy_driver/Helper/CustomTheme.dart';
import 'package:easy_driver/Helper/helper.dart';
import 'package:easy_driver/controllers/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signUpScreen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      id: 'register-screen',
      builder:(controller)=> Scaffold(
          body: SizedBox(
        width: Helper.getScreenWidth(context),
        height: Helper.getScreenHeight(context),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text("Sign Up", style: Helper.getTheme(context).headline6,),
                ),
                const Spacer(),
                const Text("Add your details to sign up"),
                const SizedBox(height: 10),
                Visibility(
                  visible: !controller.getCodeSent(),
                  child: TextFormField(
                    controller: controller.nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Username"
                    ),
                  ),
                ),
                const SizedBox(height: 30),
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
                        controller.hasAccount = false;
                        controller.sendOtp(context);
                      },
                      child: const Text("Sign up"),
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
                        // Navigator.of(context)
                        //     .pushReplacementNamed(IntroScreen.routeName);
                        controller.verifyOtp(context);
                      },
                      child: const Text("Verify Otp"),
                    ),
                  ),
                ),
                Visibility(
                    visible: controller.getIsLoading(),
                    child: CircularProgressIndicator(backgroundColor: CustomColors.primary)
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(()=>const FirebaseLogin());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an Account?"),
                      Text(
                        "Login",
                        style: TextStyle(
                          color: CustomColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
