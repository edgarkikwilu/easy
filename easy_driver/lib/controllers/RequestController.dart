import 'package:get/get.dart';

class RequestController extends GetxController{

  Future<int> loadNewRequests() async{
    int result = 0;

    await Future.delayed(const Duration(seconds: 1),(){
      result = 2;
    });

    return result;
  }

}