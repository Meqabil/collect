import 'package:collect/controller/auth/login_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/constants/assets/app_images.dart';
import 'package:collect/core/constants/regex/regex.dart';
import 'package:collect/view/widgets/auth/auth_button.dart';
import 'package:collect/view/widgets/auth/auth_input.dart';
import 'package:collect/view/widgets/auth/or_cross.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    LoginControllerImpl controller = Get.find();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        height: !isNotPhone && isPortrait ? appSizes.height/1.6  : isNotPhone ? appSizes.height * .55 : appSizes.height * 1.2,
        child: Form(
          key: controller.globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AuthInput(controller: controller.emailController,title: "email".tr,hint: 'example_gmail'.tr,icon: Icons.email_outlined,validator: (val) => validateEmail(val),),
              SizedBox(height: appSizes.height * 0.01,),
              AuthInput(controller: controller.passwordController,title: "password".tr,hint: '●●●●●●●●●',icon: Icons.lock_outline,validator: (val) => (val == null || val.isEmpty) ? 'field_not_empty'.tr : null,),

              TextButton(
                onPressed: (){
                  bool valid = validatePassword(controller.emailController.text) == null;
                  if(valid){
                    controller.sendResetPassword(controller.emailController.text.trim());
                  }
                },
                child: Text("forgot_password".tr,style: TextStyle(color: Colors.green),),
              ),
              SizedBox(height: appSizes.height * 0.025,),
              Obx(
                () => controller.loading.value == false ? AuthButton(
                    onPressed: (){
                      if(controller.loadingGoogle.value) return;
                      if(controller.globalKey.currentState!.validate()){
                        controller.login();
                      }
                    },
                    title: "login".tr
                ) : Center(child: CircularProgressIndicator(color: AppColors.mainAppColor,),)
              ),
              appSizes.height < 650 ? Container() : SizedBox(height: appSizes.height * 0.025,),
              appSizes.height < 650 ? Container() : OrCross(),
              SizedBox(height: appSizes.height * 0.025,),
              Obx(
                () => controller.loadingGoogle.value == false ? ElevatedButton(
                      onPressed: (){
                        if(controller.loading.value) return;
                        controller.loginWithGoogle();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(width: 1,color: Colors.grey),
                        fixedSize: Size(appSizes.width - 24, 45),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("sign_in_with_google".tr,style: TextStyle(color: AppColors.mainAppColor),),
                          SizedBox(width: 15,),
                          Image.asset(AppImages.google,width: 22,height: 22,)
                        ],
                      )
                  ) : Center(child: CircularProgressIndicator(color: AppColors.mainAppColor,),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
