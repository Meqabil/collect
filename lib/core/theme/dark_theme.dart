import 'package:collect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../constants/assets/app_fonts.dart';

class DarkTheme {
  static ThemeData get theme {
    return ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,fontFamily: AppFonts.cairo,color: Colors.white),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.mainAppColor,
        selectionColor: Colors.green,
        selectionHandleColor: AppColors.mainAppColor
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: AppColors.mainBlack,
        onSecondary: Colors.grey,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.black,
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.black,
      fontFamily: AppFonts.cairo,
    );
  }
}