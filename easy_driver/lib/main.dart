import 'package:easy_driver/Helper/CustomTheme.dart';
import 'package:easy_driver/controllers/NotificationController.dart';
import 'package:easy_driver/spashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  final NotificationController _notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Driver App',
      theme: CustomTheme.getLightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
