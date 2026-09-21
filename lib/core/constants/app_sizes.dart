import 'package:flutter/material.dart';

class AppSizes {
  AppSizes({required this.context});
  BuildContext context;
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}