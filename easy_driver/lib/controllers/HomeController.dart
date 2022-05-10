import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  TextEditingController searchController = TextEditingController();

  int _selectedIndex = 0;

  int getSelectedIndex() => _selectedIndex;

  setSelectedIndex(int index){
    _selectedIndex = index;
    update(['home']);
  }
}