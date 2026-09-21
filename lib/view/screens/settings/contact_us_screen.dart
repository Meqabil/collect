
import 'package:collect/controller/settings/contact_us_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/view/widgets/debtors/main_button.dart';
import 'package:collect/view/widgets/settings/list_tile_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../core/constants/assets/app_images.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ContactUsControllerImpl controller = Get.put(ContactUsControllerImpl());
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    return Scaffold(
      appBar: AppBar(
        title: Text("contact_us".tr),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: appSizes.width,
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: appSizes.height * 0.015,),
              Image.asset(AppImages.appIcon,width: !isNotPhone && isPortrait ? appSizes.width / 4 : appSizes.width * 0.1,),
              SizedBox(height: appSizes.height * 0.025,),
              Text("Collect",style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.021 : appSizes.width * 0.021 ,fontWeight: FontWeight.bold),),
              Text("we_are_here_to_help".tr,style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.015 : appSizes.width * 0.015,color: Colors.grey.shade500,),),
              SizedBox(height: appSizes.height * 0.005,),

              Container(
                padding: EdgeInsets.symmetric(vertical: appSizes.height * 0.005,horizontal: 0),
                margin: EdgeInsets.symmetric(vertical: appSizes.height * 0.005,horizontal: 0),
                decoration: BoxDecoration(
                  border: Border.all(width: .7),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListTileSettings(
                  title: "phone".tr,
                  subTitle: "01091372608",
                  trailingText: "",
                  icon: Icons.call,
                  onTap: (){
                    controller.contactUs();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: appSizes.height * 0.005,horizontal: 0),
                margin: EdgeInsets.symmetric(vertical: appSizes.height * 0.005,horizontal: 0),
                decoration: BoxDecoration(
                  border: Border.all(width: .7),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListTileSettings(
                  title: "email".tr,
                  subTitle: "mohmmedmek1234@gmail.com",
                  trailingText: "",
                  icon: Icons.email_outlined,
                  onTap: (){
                    controller.emailUs();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
                margin: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
                decoration: BoxDecoration(
                    border: Border.all(width: .7),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: ListTileSettings(
                  title: "address".tr,
                  subTitle: "Sharqia - Egypt",
                  trailingText: "",
                  icon: Icons.location_on,
                ),
              ),

              MainButton(
                title: "send_us_on_whatsapp".tr,
                width: appSizes.width,
                onTap: (){
                  controller.sendUsOnWhatsApp(phone: "201091376258", message: "");
                }
              ),

              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
