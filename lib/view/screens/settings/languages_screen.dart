import 'package:collect/controller/localization/localization_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/constants/assets/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

List flags = [AppImages.egypt,AppImages.uk,AppImages.france,AppImages.spain,AppImages.germany,AppImages.italy,AppImages.japan,AppImages.china,];
List names = ["arabic","english",'french','spanish','dutch','italian','japanese','chinese'];
List natives = ["العربية","English",'Français','Español','Deutsch','Italiano','日本語','中文'];
List langCodes = ["ar","en",'fr','es','de','it','jp','cn'];
class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LocalizationControllerImpl controller = Get.put(LocalizationControllerImpl());
    AppSizes appSizes = AppSizes(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text('languages'.tr),
      ),
      body: Container(
        width: appSizes.width,
        height: appSizes.height,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Text("chose_language".tr),
            Expanded(
              child: ListView.builder(
                itemCount: flags.length,
                itemBuilder: (context,idx){
                  return CheckboxListTile(
                    value: controller.langCode == langCodes[idx],
                    title: Text('${natives[idx]}',style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text("${names[idx]}"),
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
                    checkboxScaleFactor: 1.4,
                    tileColor: controller.langCode == langCodes[idx] ? Colors.green.withAlpha(40) : Colors.transparent,
                    secondary: Image.asset(flags[idx],width: 45,),
                    onChanged: (v){
                      controller.changeLanguage(langCodes[idx],names[idx]);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
