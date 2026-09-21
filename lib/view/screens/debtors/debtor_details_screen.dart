import 'package:collect/controller/debtors/debtor_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/view/widgets/shared/text_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../widgets/debtors/debtor_input.dart';
import '../../widgets/debtors/main_button.dart';
import '../../widgets/debts/debt_filter_chip.dart';

class DebtorDetailsScreen extends StatelessWidget {
  const DebtorDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    DebtorControllerImpl controller = Get.find();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: appSizes.width,
            height: !isNotPhone ? isPortrait ? appSizes.height / 1.2 : appSizes.height * 1.4 : appSizes.height * .7,
            padding: EdgeInsets.symmetric(horizontal: appSizes.height * 0.01,vertical: appSizes.height * 0.01),
            color: Theme.of(context).colorScheme.primary,
            child: GetBuilder<DebtorControllerImpl>(
              builder: (context) {
                return Column(
                  spacing: appSizes.height * 0.016,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("debtor_details".tr,style: TextStyle(fontSize: appSizes.height * 0.021,fontWeight: FontWeight.bold),),

                    DebtorInput(
                      label: "full_name".tr,
                      hint: "mohammed_emad".tr,
                      controller: controller.nameController,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "field_not_empty".tr;
                        }
                        return null;
                      },
                      required: true,
                    ),
                    DebtorInput(
                      label: "phone_number".tr,
                      hint: "01025654894",
                      controller: controller.phoneController,
                      required: false,
                      numbersOnly: true,
                    ),
                    DebtorInput(
                      hint: "suez".tr,
                      controller: controller.addressController,
                      label: "address".tr,
                      required: false,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          DebtFilterChip(
                            title: "personal".tr,
                            icon: Icons.person,
                            selected: controller.category == "personal",
                            color: Colors.green,
                            onTap: (){
                              controller.updateCategory('personal');
                            },
                          ),
                          DebtFilterChip(
                            title: "business".tr,
                            icon: Icons.business,
                            selected: controller.category == "business",
                            color: Colors.green,
                            onTap: (){
                              controller.updateCategory('business');
                            },
                          ),
                          DebtFilterChip(
                            title: "other".tr,
                            icon: Icons.more_vert,
                            selected: controller.category == "other",
                            color: Colors.green,
                            onTap: (){
                              controller.updateCategory('other');
                            },
                          ),

                        ],
                      ),
                    ),
                    Spacer(),
                    Text("notes".tr,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    TextArea(text: "write_any_notes".tr, controller: controller.notesController),
                    MainButton(
                      title: "next".tr,
                      width: appSizes.width,
                      onTap: (){
                        if(controller.key.currentState?.validate() ?? false){
                          controller.pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.ease);
                        }
                      },
                    )
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
