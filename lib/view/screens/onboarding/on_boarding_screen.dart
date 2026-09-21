import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/constants/assets/app_images.dart';
import 'package:collect/core/routes/app_routes.dart';
import 'package:collect/core/theme/app_colors.dart';
import 'package:collect/main.dart';
import 'package:collect/view/widgets/onboarding/on_boarding_dots.dart';
import 'package:collect/view/widgets/onboarding/on_boarding_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int pageNum = 0;
  PageController controller = PageController();

  @override
  void initState() {
    print(prefs?.getString('onboarding'));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: appSizes.width,
            height: !isNotPhone && isPortrait ? appSizes.height - 50 : !isNotPhone ? appSizes.width / 1.2 : appSizes.height * 1.1,
            child: Column(
              children: [
                SizedBox(
                  height: !isNotPhone && isPortrait ? appSizes.height / 1.4 : isNotPhone ? appSizes.height / 1.1  : appSizes.width / 1.6,
                  child: PageView(
                    controller: controller,
                    onPageChanged: (pageNumber){
                      pageNum = pageNumber;
                      setState(() {
                      });
                    },
                    children: [
                      OnBoardingItem(image: AppImages.onBoarding1,title: "onboarding_1_title".tr,description: "onboarding_1_content".tr,),
                      OnBoardingItem(image: AppImages.onBoarding2,title: "onboarding_2_title".tr,description: "onboarding_2_content".tr,hasShadow: true,),
                      OnBoardingItem(image: AppImages.onBoarding3,title: "onboarding_3_title".tr,description: "onboarding_3_content".tr,)
                    ],
                  ),
                ),
                Spacer(),
                OnBoardingDots(pageNum: pageNum),
                SizedBox(height: 5,),
                ElevatedButton(
                  onPressed: (){
                    controller.animateToPage(
                      pageNum + 1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn
                    );
                    if(pageNum == 2){
                      prefs!.setString('onboarding', 'yes');
                      Get.toNamed(AppRoutes.auth);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainAppColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    fixedSize: Size(appSizes.width / 1.5, 45),
                  ),
                  child: Text(pageNum == 2 ? 'skip'.tr : "next".tr,style: TextStyle(color: Colors.white),)
                ),
                SizedBox(height: 10,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
