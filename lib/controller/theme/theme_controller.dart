import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeController extends GetxController{

  Future<void> loadTheme();
  Future<void> toggleTheme();
  Future<void> setDarkMode(bool val);
}

class ThemeControllerImpl extends ThemeController{

  static const String _themeKey = "is_dark_mode";
  final RxBool isDarkMode = false.obs;

  @override
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool(_themeKey) ?? false;
  }

  @override
  Future<void> setDarkMode(bool val) async {
    isDarkMode.value = val;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themeKey, val);
    Get.changeThemeMode(
       val ? ThemeMode.dark : ThemeMode.light
    );
  }

  @override
  Future<void> toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themeKey, isDarkMode.value);
    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light
    );
  }


  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }
}