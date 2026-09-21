import 'package:collect/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key,required this.onPressed,required this.title});
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainAppColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          ),
          fixedSize: Size(appSizes.width - 24, 45),
        ),
        child: Text(title,textScaler: TextScaler.linear(1.2),style: TextStyle(color: Colors.white),)
    );
  }
}
