import 'package:collect/controller/debtors/debtor_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/data/models/debtors/debtor_model.dart';
import 'package:collect/view/widgets/shared/text_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/debtors/debtor_input.dart';
import '../../widgets/debtors/main_button.dart';
import '../../widgets/debts/debt_filter_chip.dart';

class EditDebtorScreen extends StatefulWidget {
  const EditDebtorScreen({super.key,required this.model});
  final DebtorModel model;

  @override
  State<EditDebtorScreen> createState() => _EditDebtorScreenState();
}

class _EditDebtorScreenState extends State<EditDebtorScreen> {
  DebtorControllerImpl controller = Get.find();
  GlobalKey<FormState> globalKey = GlobalKey();
  @override
  void initState() {
    controller.category = widget.model.category;
    controller.nameController.text = widget.model.name;
    controller.phoneController.text = widget.model.phone;
    controller.addressController.text = widget.model.address;
    controller.notesController.text = widget.model.note;
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
          child: Container(
            width: appSizes.width,
            height: !isNotPhone ? isPortrait ? appSizes.height - 70 : appSizes.height * 1.8: appSizes.height * .95,
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: GetBuilder<DebtorControllerImpl>(
                builder: (con) {
                  return Form(
                    key: globalKey,
                    child: Column(
                      spacing: 15,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("edit_debtor_details".tr,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
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
                          label: "address".tr,
                          controller: controller.addressController,
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
                          title: "update".tr,
                          width: appSizes.width,
                          onTap: () async{
                            if(globalKey.currentState!.validate()){
                              controller.updateDebtor(debtorId: widget.model.id, name: controller.nameController.text.trim(), phoneNumber: controller.phoneController.text.trim(), address: controller.addressController.text.trim(), note: controller.notesController.text.trim());
                              Get.back();
                              Get.defaultDialog(
                                barrierDismissible: false,
                                backgroundColor: Colors.transparent,
                                title: '',
                                content: Container(
                                  alignment: Alignment.center,
                                  width: 300,
                                  height: 150,
                                  color: Theme.of(context).colorScheme.primary,
                                  child: CircularProgressIndicator(color: AppColors.mainAppColor,),
                                )
                              );
                              controller.clear();
                              await Future.delayed(Duration(seconds: 2),);
                              Get.back();
                              Get.back();
                            }
                          },
                        )
                      ],
                    ),
                  );
                }
            ),
          ),
        ),
      ),
    );
  }
}
