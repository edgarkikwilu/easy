import 'package:easy_driver/Helper/CustomTheme.dart';
import 'package:easy_driver/controllers/AccountController.dart';
import 'package:easy_driver/controllers/HomeController.dart';
import 'package:easy_driver/controllers/MapController.dart';
import 'package:easy_driver/controllers/MapController.dart';
import 'package:easy_driver/controllers/RequestController.dart';
import 'package:easy_driver/controllers/RequestController.dart';
import 'package:easy_driver/tabs/AccountTab/account_home.dart';
import 'package:easy_driver/tabs/DeliveryTab/Map.dart';
import 'package:easy_driver/tabs/NewRequestTab/NewRequests.dart';
import 'package:easy_driver/tabs/OrdersTab/RequestHistory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget{
  final HomeController _homeController = Get.put(HomeController());
  final AccountController _accountController = Get.put(AccountController());
  final MapController _mapController = Get.put(MapController());
  final RequestController _requestController = Get.put(RequestController());

  Home({Key? key}) : super(key: key);

  static final List<Widget> _pages = <Widget>[
    MapPage(),
    const AccountHomePage(),
    const NewRequestPage(),
    const RequestHistory()
  ];
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'home',
      builder: (controller)=>Scaffold(
        body: _pages.elementAt(controller.getSelectedIndex()),
        bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFFFFFFF),
        selectedItemColor: CustomColors.primary,
        unselectedItemColor: CustomColors.someGray.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: controller.getSelectedIndex(),
        onTap: (value) {
          controller.setSelectedIndex(value);
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Delivery',
            icon: Icon(Icons.place_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(Icons.account_circle_outlined),
          ),
          BottomNavigationBarItem(
            label: 'New Request',
            icon: Icon(Icons.notifications_active_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Orders',
            icon: Icon(Icons.receipt_outlined),
          ),

        ],
      ),
    ));
  }
}