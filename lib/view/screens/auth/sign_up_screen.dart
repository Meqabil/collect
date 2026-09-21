import 'package:collect/controller/auth/sign_up_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/view/widgets/auth/auth_input.dart';
import 'package:collect/core/constants/regex/regex.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    SignUpControllerImpl controller = Get.find();
    return SingleChildScrollView(
      child: Container(
        height: !isNotPhone && isPortrait ? appSizes.height/ 1.6  : isNotPhone ? appSizes.height * .7 : appSizes.height * 1,
        padding: EdgeInsets.all(8),
        child: Form(
          key: controller.globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AuthInput(controller: controller.nameController,title: "full_name".tr,hint: 'mohammed_emad'.tr,icon: Icons.person_outline_rounded,validator: (val) {
                if(val == null  || val.isEmpty) return 'field_not_empty'.tr;
                return null;
              },),
              SizedBox(height: appSizes.height * .01,),
              AuthInput(controller: controller.emailController,title: "email".tr,hint: 'example_gmail'.tr,icon: Icons.email_outlined,validator: (val) => validateEmail(val),),
              SizedBox(height: appSizes.height * .01,),
              AuthInput(controller: controller.passwordController,title: "password".tr,hint: '●●●●●●●●●',icon: Icons.lock_outline,validator: (val) => validatePassword(val),),

              SizedBox(height: appSizes.height * .025,),
              Obx(
                () => controller.loading.value ? Center(child: CircularProgressIndicator(color: AppColors.mainAppColor,),) :
                ElevatedButton(
                    onPressed: (){
                      if(controller.globalKey.currentState!.validate()){
                        controller.signUp();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainAppColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      fixedSize: Size(appSizes.width - 24, 45),
                    ),
                    child: Text("sign_up".tr,style: TextStyle(color: Colors.white),)
                )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
