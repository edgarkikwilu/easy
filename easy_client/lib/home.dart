import 'package:easy_client/Helper/CustomTheme.dart';
import 'package:easy_client/controllers/HomeController.dart';
import 'package:easy_client/home_tab/Landing.dart';
import 'package:easy_client/profile_tab/ProfileLanding.dart';
import 'package:easy_client/wallet_tab/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget{
  const Home({Key? key}) : super(key: key);

  static final List<Widget> _pages = <Widget>[
    LandingPage(),
    WalletPage(),
    ProfileLanding(),
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
            label: 'Home',
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Pay',
            icon: Icon(Icons.money),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.account_circle_rounded),
          ),

        ],
      ),
    ));
  }
}