import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({super.key,required this.title,required this.onTap,this.color});
  final String title;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(appSizes.width, 40),
        backgroundColor: color ?? AppColors.mainAppColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        )
      ),
      onPressed: onTap,
      child: Row(
        children: [
          Text(title,style: TextStyle(color: color == null || color == Colors.white ? AppColors.mainAppColor : Colors.white),),
          Spacer(),
          Icon(Icons.calendar_month,color: color == null || color == Colors.white ? AppColors.mainAppColor : Colors.white)
        ],
      ),
    );
  }
}
