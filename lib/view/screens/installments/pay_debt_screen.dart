import 'package:collect/controller/debtors/debtor_controller.dart';
import 'package:collect/controller/debts/debts_controller.dart';
import 'package:collect/controller/installments/installments_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/constants/assets/app_images.dart';
import 'package:collect/view/widgets/debtors/calendar_button.dart';
import 'package:collect/view/widgets/debtors/debtor_input.dart';
import 'package:collect/view/widgets/debtors/dialog_date.dart';
import 'package:collect/view/widgets/debtors/main_button.dart';
import 'package:collect/view/widgets/installments/payment_button.dart';
import 'package:collect/view/widgets/shared/text_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
class PayDebtScreen extends StatelessWidget {
  const PayDebtScreen({super.key,required this.debtId,required this.debtorId});
  final String debtId;
  final String debtorId;
  @override
  Widget build(BuildContext context) {
    InstallmentsControllerImpl controller = Get.find();
    DebtorControllerImpl debtorController = Get.find();
    DebtsControllerImpl debtsController = Get.find();
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    return Scaffold(
      appBar: AppBar(
        title: Text("pay_installment".tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: appSizes.width,
          height: !isNotPhone && isPortrait ? appSizes.height + 16 : appSizes.width + 16,

          padding: EdgeInsets.symmetric(horizontal: 11,vertical: 8),
          child: Form(
            key: controller.globalKey,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppImages.payingMethods,width: 222,),
                          ],
                        ),
                        Text("next_pay_date".tr,style: TextStyle(fontWeight: FontWeight.bold),),
                        GetBuilder<InstallmentsControllerImpl>(
                          builder: (con) {
                            return CalendarButton(
                              title: controller.debtDate.toString().substring(0,10),
                              color: Theme.of(context).colorScheme.primary,
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (con){
                                    return DialogDate(
                                      initialDate: controller.debtDate,
                                      onChangeDate: (date){
                                        controller.changeDate(date);
                                        Get.back();
                                      },
                                    );
                                  }
                                );
                              }
                            );
                          }
                        ),
                        SizedBox(height: 12,),
                        DebtorInput(
                          hint: "0.0",
                          label: "payed_money".tr,
                          required: true,
                          controller: controller.moneyController,
                          numbersOnly: true,
                          validator: (v){
                            if(v == null || v.isEmpty) return 'field_not_empty'.tr;
                            return null;
                          },
                        ),
                        SizedBox(height: 12,),
                        Text("payment_methods".tr,style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 6,),
                        GetBuilder<InstallmentsControllerImpl>(
                          builder: (context) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PaymentButton(
                                  size: 71,
                                  icon: Icons.money,
                                  title: "cash".tr,
                                  selected: controller.payWay == "Cash",
                                  onTap: (){
                                    controller.updatePayingMethod("Cash");
                                  },
                                ),
                                PaymentButton(
                                  size: 71,
                                  icon: Icons.credit_card,
                                  title: "check".tr,
                                  selected: controller.payWay == "Check",
                                  onTap: (){
                                    controller.updatePayingMethod("Check");
                                  },
                                ),
                                PaymentButton(
                                  size: 71,
                                  icon: Icons.account_balance,
                                  title: "bank_deposit".tr,
                                  selected: controller.payWay == "Bank deposit",
                                  onTap: (){
                                    controller.updatePayingMethod("Bank deposit");
                                  },
                                ),
                                PaymentButton(
                                  size: 71,
                                  icon: Icons.more,
                                  title: "other".tr,
                                  selected: controller.payWay == "Other",
                                  onTap: (){
                                    controller.updatePayingMethod("Other");
                                  },
                                ),
                              ],
                            );
                          }
                        ),
                        SizedBox(height: 22,),
                        Text("mean_of_contact".tr,style: TextStyle(fontWeight: FontWeight.bold),),
                        Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(vertical: 2,horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1,color: Colors.grey)
                          ),
                          child: GetBuilder<InstallmentsControllerImpl>(
                            builder: (context) {
                              return DropdownButton(
                                icon: Icon(Icons.keyboard_arrow_down_rounded),
                                underline: Container(),
                                isExpanded: true,
                                value: controller.contact,
                                style: TextStyle(color: Colors.grey.shade600),
                                items: controller.means.map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text("${e.tr} "),
                                  )
                                ).toList() ,
                                onChanged: (v){
                                  controller.updateMean(v ?? controller.contact);
                                },
                              );
                            }
                          ),
                        ),
                        SizedBox(height: 22,),
                        Text("notes".tr,style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 11,),
                        TextArea(
                          text: "write_any_notes".tr,
                          controller: controller.notesController
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                MainButton(
                  title: "record".tr,
                  width: appSizes.width,
                  onTap: () async{
                    if(controller.globalKey.currentState!.validate()){
                      controller.payInstallment(
                          debtId: debtId,
                          debtorId: debtorId,
                          installment: double.parse(controller.moneyController.text.trim()),
                          note: controller.notesController.text.trim(),
                          method: controller.payWay,
                          meanOfContact: controller.contact,
                          nextDate: controller.debtDate
                      );
                      Get.back();
                      Get.defaultDialog(
                          barrierDismissible: false,
                          title: '',
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
                      controller.moneyController.clear();
                      controller.notesController.clear();
                      controller.changeDate(DateTime.now());
                      debtsController.clear();
                      debtorController.clear();
                      Get.back();
                      Get.back();
                    }

                  }
                ),
                SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
