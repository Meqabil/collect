import 'package:collect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  const Dot({super.key,required this.width,required this.idx,required this.pageNum});
  final double width;
  final int idx;
  final int pageNum;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: idx == pageNum ? width * 1.1 : width,
      height: idx == pageNum ? width * 1.1 : width,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: idx == pageNum ? AppColors.mainAppColor : Colors.grey,
          borderRadius: BorderRadius.circular(90)
      ),
    );
  }
}
