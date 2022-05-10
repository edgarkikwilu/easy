import 'package:easy_client/Auth/login.dart';
import 'package:easy_client/Helper/CustomTheme.dart';
import 'package:easy_client/controllers/HomeController.dart';
import 'package:easy_client/controllers/NotificationController.dart';
import 'package:easy_client/spashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

initAppMessaging() async{
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  firebaseMessaging.getToken().then((value)async{
    print("FCM Token: $value");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("firebaseDeviceToken", value!);
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification!.android;

    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');


    if (message.notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification!.title,
          notification!.body,
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id,channel.name)
          )
      );
      print("${message.notification!.title}");
      print('Message also contained a notification: ${message.notification}');
    }
  });
  //NotificationSettings settings =
  await firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

initLocalNotificationPlugin()async{
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}){
    initLocalNotificationPlugin();
    initAppMessaging();
  }

  final NotificationController _notificationController = Get.put(NotificationController());
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Easy',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}


