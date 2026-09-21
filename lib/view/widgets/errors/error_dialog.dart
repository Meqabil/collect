
import 'package:collect/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../debtors/main_button.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key,required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    print(message);
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: appSizes.width * .1,vertical: 0),
      child: Container(
        width: appSizes.width ,
        color: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(40),
                borderRadius: BorderRadius.circular(90)
              ),
              child: Icon(Icons.error_outline,color: Colors.red,size: 45,)
            ),
            SizedBox(height: 10,),
            Text("error_happened".tr,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
            Text(message,style: TextStyle(color: Colors.grey.shade500,),textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            MainButton(
              title: "ok".tr,
              width: double.infinity,
              onTap: (){
                Get.back();
              }
            )
          ],
        ),
      ),
    );
  }
}
