import 'package:collect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../constants/assets/app_fonts.dart';

class LightTheme {
  static ThemeData get theme {
    return ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,fontFamily: AppFonts.cairo,color: Colors.black),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.mainAppColor,
        selectionColor: Colors.green,
        selectionHandleColor: AppColors.mainAppColor
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Colors.white,
        onPrimary: AppColors.mainBlack,
        secondary: Colors.white,
        onSecondary: Colors.black87,
        error: Colors.red,
        onError: Colors.red,
        surface: Colors.white,
        onSurface: Colors.black,

      ),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: AppFonts.cairo,
    );
  }
}