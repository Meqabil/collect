
import 'package:collect/controller/auth/login_controller.dart';
import 'package:collect/controller/localization/localization_controller.dart';
import 'package:collect/controller/theme/theme_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/view/screens/settings/about_app_screen.dart';
import 'package:collect/view/screens/settings/contact_us_screen.dart';
import 'package:collect/view/screens/settings/contexts_screen.dart';
import 'package:collect/view/screens/settings/help_center_screen.dart';
import 'package:collect/view/screens/settings/languages_screen.dart';
import 'package:collect/view/widgets/auth/auth_button.dart';
import 'package:collect/view/widgets/settings/list_tile_settings.dart';
import 'package:collect/view/widgets/settings/owner_board.dart';
import 'package:collect/view/widgets/settings/switch_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    ThemeControllerImpl controller = Get.put(ThemeControllerImpl());
    LoginControllerImpl loginController = Get.find();
    LocalizationControllerImpl localizationController = Get.put(LocalizationControllerImpl());

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("settings".tr,textScaler: TextScaler.linear(1),style: TextStyle(fontWeight: FontWeight.bold),),

        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: appSizes.width,
          height: isPortrait  || appSizes.height > 600 ? appSizes.height : appSizes.height * 1.7,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
          child: Column(
            spacing: appSizes.height * 0.016,
            children: [
              OwnerBoard(name: FirebaseAuth.instance.currentUser?.displayName ?? '', email: FirebaseAuth.instance.currentUser?.email ?? '',image: FirebaseAuth.instance.currentUser?.photoURL,),
              Expanded(
                child: Container(
                  width: appSizes.width,
                  padding: EdgeInsets.symmetric(horizontal: appSizes.height * 0.01,vertical: appSizes.height * 0.013),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(10),
                        blurRadius: 35,
                        spreadRadius: 0,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: Colors.black.withAlpha(12),
                        blurRadius: 15,
                        spreadRadius: -2,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("appearance".tr,textScaler: TextScaler.linear(1),style: TextStyle(fontSize: appSizes.height * 0.021,fontWeight: FontWeight.bold),),
                      SizedBox(height: appSizes.height * 0.01,),
                      Obx(
                        () => SwitchSettings(
                            value: controller.isDarkMode.value,
                            title: "dark_mode".tr,
                            subTitle: "dark_mode_text".tr,
                            onChanged: controller.setDarkMode,
                          )
                      ),

                      Divider(thickness: .5,),
                      ListTileSettings(
                        title: "language".tr,
                        subTitle: "change_lang".tr,
                        trailingText: localizationController.langName.tr,
                        icon: Icons.language,
                        onTap: (){
                          Get.to(() => LanguagesScreen());
                          // HomeControllerImpl con = Get.find();
                          // con.update();
                        },
                      ),
                      SizedBox(height: appSizes.height * 0.02,),
                      Text("general".tr,textScaler: TextScaler.linear(1),style: TextStyle(fontSize: appSizes.height * 0.021,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      ListTileSettings(
                        title: "contexts".tr,
                        subTitle: "context_for_debtors".tr,
                        trailingText: "",
                        icon: Icons.help_outline,
                        onTap: (){
                          Get.to(() => ContextsScreen());
                        },
                      ),
                      Divider(thickness: .5,),
                      SizedBox(height: appSizes.height * 0.02,),
                      Text("about".tr,textScaler: TextScaler.linear(1),style: TextStyle(fontSize: appSizes.height * 0.021,fontWeight: FontWeight.bold),),
                      SizedBox(height: appSizes.height * 0.01,),
                      ListTileSettings(
                        title: "help_center".tr,
                        subTitle: "common_questions".tr,
                        trailingText: "",
                        icon: Icons.help_outline,
                        onTap: (){
                          Get.to(() => HelpCenterScreen());
                        },
                      ),
                      Divider(thickness: .5,),
                      ListTileSettings(
                        title: "about_app".tr,
                        subTitle: "terms_and_conditions".tr,
                        trailingText: "",
                        icon: Icons.info_outline,
                        onTap: (){
                          Get.to(() => AboutAppScreen());
                        },
                      ),
                      Divider(thickness: .5,),
                      ListTileSettings(
                        title: "contact_us".tr,
                        subTitle: "we_are_here_to_help".tr,
                        trailingText: "",
                        icon: Icons.headphones,
                        onTap: (){
                          Get.to(() => ContactUsScreen());
                        },
                      ),
                      Spacer(),
                      AuthButton(
                        onPressed: (){
                          loginController.signOut();
                        },
                        title: 'sign_out'.tr
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
