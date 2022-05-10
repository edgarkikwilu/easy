import 'package:easy_driver/Helper/notification.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController{
  String? notificationTitle = 'No Title';
  String? notificationBody = 'No Body';
  String? notificationData = 'No Data';

  @override
  onInit(){
    super.onInit();
    print("notification controller initialized");
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
  }

  _changeData(String? msg){
    notificationData = msg;
  }
  _changeBody(String? msg){
    notificationBody = msg;
  }
  _changeTitle(String? msg) {
    notificationTitle = msg;
  }
}