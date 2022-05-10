import 'package:easy_client/Helper/notification.dart';
import 'package:easy_client/controllers/MapController.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController{
  String? notificationTitle = 'No Title';
  String? notificationBody = 'No Body';
  String? notificationData = 'No Data';

  late MapController _mapController;

  @override
  onInit(){
    super.onInit();
    print("notification controller initialized");
    _mapController = Get.put(MapController());
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
  }

  _changeData(String? msg){
    notificationData = msg;
    print(msg);
  }
  _changeBody(String? msg){
    notificationBody = msg;
    print(msg);
  }
  _changeTitle(String? msg) {
    notificationTitle = msg;
    print(msg);
  }
}