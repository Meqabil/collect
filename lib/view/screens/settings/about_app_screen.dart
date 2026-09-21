import 'package:collect/core/constants/assets/app_images.dart';
import 'package:collect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_sizes.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    return Scaffold(
      appBar: AppBar(
        title: Text("about_app".tr),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: appSizes.width,
          //height: !isNotPhone && isPortrait ? appSizes.height : appSizes.height * 1.3,
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          child: Column(
            spacing: 2,
            children: [
              SizedBox(height: appSizes.height * 0.015,),
              Image.asset(AppImages.appIcon,width: isPortrait && !isNotPhone ? appSizes.width / 4 : appSizes.width * 0.1,),
              SizedBox(height: appSizes.height * 0.025,),
              Text("Collect",style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.021 : appSizes.width * 0.021,fontWeight: FontWeight.bold),),
              Text("manage_and_follow".tr,style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.013 : appSizes.width * 0.013,color: Colors.grey.shade500,),),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withAlpha(40),
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Text("Version 1.0.0",style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.011 : appSizes.width * 0.011,color: AppColors.mainAppColor,))
              ),
              SizedBox(height: 20,),
              Container(
                width: appSizes.width,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      spreadRadius: 1.2,
                      blurRadius: 1.5
                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text("version_date".tr,style: TextStyle(color: Colors.grey.shade600,fontSize: isPortrait ? appSizes.height * 0.013 : appSizes.width * 0.013,fontWeight: FontWeight.bold),),
                      leading: Icon(Icons.date_range_sharp,color: AppColors.mainAppColor,),
                      trailing: Text("1 January 2027",style: TextStyle(color: Colors.grey.shade600,fontSize: isPortrait ? appSizes.height * 0.012 : appSizes.width * 0.012,fontWeight: FontWeight.bold),),
                      contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                    ),
                    Divider(height: 0,),
                    ListTile(
                      title: Text("developed_by".tr,style: TextStyle(color: Colors.grey.shade600,fontSize: isPortrait ? appSizes.height * 0.013 : appSizes.width * 0.013,fontWeight: FontWeight.bold),),
                      leading: Icon(Icons.person_outline,color: AppColors.mainAppColor,),
                      trailing: Text("Meqabil",style: TextStyle(color: Colors.grey.shade600,fontSize: isPortrait ? appSizes.height * 0.013 : appSizes.width * 0.013 ,fontWeight: FontWeight.bold),),
                      contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                    ),
                    Divider(height: 0,),
                    ListTile(
                      title: Text("privacy_policy".tr,style: TextStyle(color: Colors.grey.shade600,fontSize: isPortrait ? appSizes.height * 0.013 : appSizes.width * 0.013,fontWeight: FontWeight.bold),),
                      leading: Icon(Icons.privacy_tip_outlined,color: AppColors.mainAppColor,),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,size: appSizes.height * 0.02),
                      contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
