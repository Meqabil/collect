import 'package:collect/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class DebtSquareMoney extends StatelessWidget {
  const DebtSquareMoney({super.key,required this.title,required this.value,required this.icon,required this.color});
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon,color: color,),
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
            padding: EdgeInsets.all(appSizes.height * 0.0148),
            backgroundColor: color.withAlpha(40)
          ),
          onPressed: (){},
        ),
        SizedBox(height: appSizes.height * 0.01,),
        Text(value,textScaler: TextScaler.linear(1),style: TextStyle(color: color,fontSize: appSizes.height * 0.015,fontWeight: FontWeight.bold),),
        Text(title,textScaler: TextScaler.linear(1),style: TextStyle(color: Colors.grey,fontSize: appSizes.height * 0.012,),),
        Text("l.e".tr,textScaler: TextScaler.linear(1),style: TextStyle(color: Colors.grey,fontSize: appSizes.height * 0.014,),),
      ],
    );
  }
}
