import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/constants/assets/app_images.dart';
import 'package:collect/core/functions/check_internet_connection.dart';
import 'package:collect/view/widgets/debtors/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.noInternet,width: appSizes.width / 2,),
              Text('no_internet_connection'.tr,style: TextStyle(fontSize: appSizes.height * .024,fontWeight: FontWeight.bold),),
              Text('make_sure_online'.tr,style: TextStyle(color: Colors.grey.shade500,fontSize: appSizes.height * 0.018),),
              SizedBox(height: 20,),
              MainButton(
                title: 'try_again'.tr,
                width: appSizes.width - 50,
                onTap: () async {
                  final internetConnection = await checkInternetConnection();
                  if(internetConnection){
                    Get.back();
                  }
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
