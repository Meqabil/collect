
import 'package:collect/view/screens/debtors/debtors_screen.dart';
import 'package:collect/view/screens/debts/debts_screen.dart';
import 'package:collect/view/screens/debts/statistics_screen.dart';
import 'package:collect/view/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeController extends GetxController{
  void changePage(int pageNumber);
}

class HomeControllerImpl extends HomeController{
  int page = 0;
  List<String> navTexts = ['home','debtors','reports','settings'];
  List navIcons = [Icons.home_outlined,Icons.people_alt_outlined,Icons.bar_chart,Icons.settings];
  List pages = [
    DebtsScreen(),
    DebtorsScreen(),
    StatisticsScreen(),
    SettingsScreen()
  ];

  @override
  changePage(int pageNumber) {
    page = pageNumber;
    update();
  }

}