
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key,required this.title,required this.width,this.color,required this.onTap});
  final String title;
  final double width;
  final Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(width, 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: color ?? AppColors.mainAppColor
      ),
      child: Text(title,style: TextStyle(color: Colors.white),),
    );
  }
}
