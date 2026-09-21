
import 'package:collect/controller/debtors/debtor_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/view/screens/debtors/debt_details_screen.dart';
import 'package:collect/view/screens/debtors/debtor_revise_screen.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import 'debtor_details_screen.dart';

class AddDebtorScreen extends StatefulWidget {
  const AddDebtorScreen({super.key});
  @override
  State<AddDebtorScreen> createState() => _AddDebtorScreenState();
}

class _AddDebtorScreenState extends State<AddDebtorScreen> {
  DebtorControllerImpl controller = Get.find();
  ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text("collect".tr,),
      ),
      body: Container(
        width: appSizes.width,
        height: appSizes.height,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              Container(
                width: appSizes.width,
                height: appSizes.height / 1.2,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(vertical: 11,horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(
                      width: appSizes.width,
                      height: 100,
                      child: EasyStepper(
                        activeStep: controller.currentStep,
                        activeStepBackgroundColor: AppColors.mainAppColor,
                        finishedStepBackgroundColor: Colors.grey.shade300,
                        unreachedStepBackgroundColor: Colors.grey.shade300,
                        fitWidth: true,
                        activeStepTextColor: Colors.green,
                        titleTextStyle: TextStyle(fontSize: 11),
                        stepShape: StepShape.circle,
                        stepRadius: 18,
                        showLoadingAnimation: false,
                        lineStyle: LineStyle(
                          lineLength: appSizes.width / 3.9,
                          lineType: LineType.normal,
                          defaultLineColor: Color(0xFFD2D2D2),
                          finishedLineColor: AppColors.mainAppColor,
                        ),
                        steps: [
                          EasyStep(
                            customStep: CircleAvatar(
                              radius: 18,
                              backgroundColor: controller.currentStep == 0 ? AppColors.mainAppColor : Colors.white,
                              child: Text('1',style: TextStyle(color: controller.currentStep == 0 ? Colors.white : AppColors.mainAppColor),),
                            ),
                            title: 'debtor_details'.tr,

                          ),
                          EasyStep(
                            customStep: CircleAvatar(
                              radius: 18,
                              backgroundColor: controller.currentStep == 1 ? AppColors.mainAppColor : Colors.white,
                              child: Text('2',style: TextStyle(color: controller.currentStep == 1 ? Colors.white : AppColors.mainAppColor))
                            ),
                            title: 'debt_details'.tr,

                          ),
                          EasyStep(
                            customStep: CircleAvatar(
                              radius: 18,
                              backgroundColor: controller.currentStep == 2 ? AppColors.mainAppColor : Colors.white,
                              child: Text('3',style: TextStyle(color: controller.currentStep == 2 ? Colors.white : AppColors.mainAppColor))
                            ),
                            title: 'revise'.tr,
                          ),
                        ],
                        onStepReached: (index) {
                          controller.pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
                          setState(() => controller.currentStep = index);
                        },

                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(122),
                              spreadRadius: 0.2,
                              blurRadius: 1.5
                            )
                          ]
                        ),
                        child: Form(
                          key: controller.key,
                          child: PageView(
                            controller: controller.pageController,
                            onPageChanged: (page){
                              controller.currentStep = page;
                              setState(() {});
                            },
                            children: [
                              DebtorDetailsScreen(),
                              DebtDetailsScreen(),
                              DebtorReviseScreen(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

