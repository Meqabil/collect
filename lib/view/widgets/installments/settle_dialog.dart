import 'package:collect/controller/debts/debts_controller.dart';
import 'package:collect/controller/installments/installments_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/debtors/debtor_controller.dart';
import '../../../core/constants/assets/app_images.dart';
import '../debtors/main_button.dart';
import '../shared/text_area.dart';

class SettleDialog extends StatelessWidget {
  const SettleDialog({super.key,required this.debtId,required this.debtorId});
  final String debtId;
  final String debtorId;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    InstallmentsControllerImpl controller = Get.find();
    DebtsControllerImpl debtsController = Get.find();
    DebtorControllerImpl debtorController = Get.find();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: appSizes.width * 0.05,horizontal: appSizes.width * 0.04),
            width: appSizes.width * .8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: appSizes.width,height: appSizes.height / 8,child: ClipRRect(borderRadius: BorderRadius.circular(8),child: Image.asset(AppImages.settle))),
                SizedBox(height: 20,),
                Text("notes".tr,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                SizedBox(height: 9,),
                TextArea(text: "write_any_notes".tr, controller: controller.notesController),
                MainButton(
                  title: "settle".tr,
                  width: appSizes.width,
                  onTap: (){
                    controller.settle(debtId: debtId, debtorId: debtorId, note: controller.notesController.text.trim());
                    debtsController.clear();
                    debtorController.clear();
                    Get.back();
                    Get.back();
                  }
                ),
                MainButton(
                  title: "cancel".tr,
                  width: appSizes.width,
                  color: Colors.grey,
                  onTap: (){
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
