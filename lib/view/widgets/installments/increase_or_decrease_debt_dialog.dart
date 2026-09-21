import 'package:collect/controller/debts/debts_controller.dart';
import 'package:collect/controller/installments/installments_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/debtors/debtor_controller.dart';
import '../debtors/debtor_input.dart';
import '../debtors/main_button.dart';
import '../shared/text_area.dart';

GlobalKey<FormState> globalKey = GlobalKey();
class IncreaseOrDecreaseDebtDialog extends StatelessWidget {
  const IncreaseOrDecreaseDebtDialog({super.key,required this.debtorId,required this.debtId,required this.increase});
  final String debtId;
  final String debtorId;
  final bool increase;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    InstallmentsControllerImpl controller = Get.find();
    DebtsControllerImpl debtsController = Get.find();
    DebtorControllerImpl debtorController = Get.find();
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25,horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DebtorInput(
                  label: "money".tr,
                  hint: "5000",
                  numbersOnly: true,
                  controller: controller.moneyController,
                  required: true,
                  validator: (v){
                    if(v == null || v.isEmpty) return 'field_not_empty'.tr;
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                Text("notes".tr,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                SizedBox(height: 9,),
                TextArea(text: "write_any_notes".tr, controller: controller.notesController),

                MainButton(
                  title: increase ? "Increase Debt" : "Decrease Debt",
                  width: appSizes.width,
                  onTap: () async{
                    if(globalKey.currentState!.validate()){
                      controller.increaseOrDecreaseDebt(debtId: debtId, debtorId: debtorId, installment: double.parse(controller.moneyController.text.trim()), note: controller.notesController.text.trim(), increase: increase);
                      Get.back();
                      Get.defaultDialog(
                          barrierDismissible: false,
                          backgroundColor: Colors.transparent,
                          content: Container(
                            alignment: Alignment.center,
                            width: 300,
                            height: 150,
                            color: Theme.of(context).colorScheme.primary,
                            child: CircularProgressIndicator(color: AppColors.mainAppColor,),
                          )
                      );
                      await Future.delayed(Duration(seconds: 1),);

                      controller.clear();
                      debtsController.clear();
                      debtorController.clear();
                      Get.back();
                      Get.back();
                    }
                  }
                ),
                MainButton(
                  title: "cancel".tr,
                  width: appSizes.width,
                  color: Colors.grey,
                  onTap: (){

                    controller.clear();
                    Get.back();
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
