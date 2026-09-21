import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  const TabButton({super.key,required this.title,required this.onTap,this.color,this.width,this.showBorder});
  final String title;
  final double? width;
  final void Function()? onTap;
  final bool? showBorder;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: (isNotPhone ? appSizes.width / 4 - 50 : width) ?? (isNotPhone ? appSizes.width / 2 - 20 : appSizes.width / 4 - 12),
        decoration: BoxDecoration(
          color: color ?? Colors.transparent,
          border: Border(bottom: BorderSide(
            width: 5,
            color: showBorder == null  || showBorder == false? Colors.transparent : AppColors.mainAppColor
          ))
        ),
        constraints: BoxConstraints(
          minHeight: 35,
        ),
        child: Text(title,style: TextStyle(color: AppColors.mainAppColor),)
      ),
    );
  }
}
