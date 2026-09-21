import 'package:collect/controller/debtors/debtor_controller.dart';
import 'package:collect/controller/debts/debts_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/theme/app_colors.dart';
import 'package:collect/data/models/debts/debt_model.dart';
import 'package:collect/view/screens/installments/pay_debt_screen.dart';
import 'package:collect/view/widgets/debtors/main_button.dart';
import 'package:collect/view/widgets/debts/ask_dialog.dart';
import 'package:collect/view/widgets/errors/error_dialog.dart';
import 'package:collect/view/widgets/installments/increase_or_decrease_debt_dialog.dart';
import 'package:collect/view/widgets/installments/settle_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/debts/debtor_action_button.dart';
import 'delay_debt_screen.dart';

class PayingOptionsView extends StatelessWidget {
  const PayingOptionsView({super.key,required this.model,required this.debtorName,required this.phoneNumber});
  final DebtModel model;

  final String debtorName;
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    DebtorControllerImpl debtorController = Get.find();
    DebtsControllerImpl debtsController = Get.find();
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      padding: const EdgeInsets.all(8),
      width: isNotPhone ? appSizes.width / 2 - 20 : appSizes.width ,
      height: isNotPhone ? null : isPortrait ? appSizes.height / 8 : appSizes.width / 8.5,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
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
      child: SizedBox(
        width: appSizes.width,
        child: isNotPhone ? SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                DebtorActionButton(
                  title: "pay".tr,
                  icon: Icons.payments_outlined,
                  color: Colors.green,
                  onTap: (){
                    Get.to(() => PayDebtScreen(debtId: model.id, debtorId: model.debtorId, ));
                  },
                ),
                DebtorActionButton(
                  title: "delay".tr,
                  icon: Icons.access_time,
                  color: Colors.orange,
                  onTap: (){
                    if(debtorName == '') return;
                    DateTime delayedFrom = model.nextDate;
                    Get.to(() => DelayDebtScreen(debtOrInstallment: model.debt.toInt().toString(),debtorName: debtorName,debtId: model.id,debtorId: model.debtorId,date: delayedFrom));
                  },
                ),
                DebtorActionButton(
                  title: "decrease".tr,
                  icon: Icons.keyboard_arrow_down_outlined,
                  color: Colors.deepPurple,
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (con){
                        return IncreaseOrDecreaseDebtDialog(
                          debtId: model.id,
                          debtorId: model.debtorId,
                          increase: false,
                        );
                      }
                    );
                  },
                ),
                DebtorActionButton(
                  title: "increase".tr,
                  icon: Icons.keyboard_arrow_up_outlined,
                  color: Colors.blue,
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (con){
                          return IncreaseOrDecreaseDebtDialog(
                            debtId: model.id,
                            debtorId: model.debtorId,
                            increase: true,
                          );
                        }
                    );
                  },
                ),
                DebtorActionButton(
                  title: "ask".tr,
                  icon: Icons.keyboard_arrow_up_outlined,
                  color: Colors.lightGreen,
                  onTap: (){
                    print("phoneNumber");
                    if(debtorName == '') return;
                    showDialog(
                      context: context,
                      builder: (con){
                        if(phoneNumber.isEmpty || phoneNumber.length < 8){
                          return AlertDialog(content: Text('you don\'t have phone number'),);
                        }else{
                          return AskDialog(phoneNumber: phoneNumber,debtorName: debtorName,money: model.debt.toInt().toString(),);
                        }
                      }
                    );
                  },
                ),
                DebtorActionButton(
                  title: "settle".tr,
                  icon: Icons.payments_sharp,
                  color: Colors.grey,
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (con){
                          return SettleDialog(debtId: model.id, debtorId: model.debtorId);
                        }
                    );
                  },
                ),
                DebtorActionButton(
                  title: "delete".tr,
                  icon: Icons.delete,
                  color: Colors.red,
                  onTap: (){

                  },
                ),
              ]
          ),
        )
            :
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DebtorActionButton(
                  title: "pay".tr,
                  icon: Icons.payments_outlined,
                  color: Colors.green,
                  onTap: (){
                    Get.to(() => PayDebtScreen(debtId: model.id, debtorId: model.debtorId, ));
                  },
                ),
                DebtorActionButton(
                  title: "delay".tr,
                  icon: Icons.access_time,
                  color: Colors.orange,
                  onTap: (){
                    if(debtorName == '') return;
                    DateTime delayedFrom = model.nextDate;
                    Get.to(() => DelayDebtScreen(debtOrInstallment: model.debt.toInt().toString(),debtorName: debtorName,debtId: model.id,debtorId: model.debtorId,date: delayedFrom));
                  },
                ),
                DebtorActionButton(
                  title: "decrease".tr,
                  icon: Icons.keyboard_arrow_down_outlined,
                  color: Colors.deepPurple,
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (con){
                          return IncreaseOrDecreaseDebtDialog(
                            debtId: model.id,
                            debtorId: model.debtorId,
                            increase: false,
                          );
                        }
                    );
                  },
                ),
                DebtorActionButton(
                  title: "increase".tr,
                  icon: Icons.keyboard_arrow_up_outlined,
                  color: Colors.blue,
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (con){
                        return IncreaseOrDecreaseDebtDialog(
                          debtId: model.id,
                          debtorId: model.debtorId,
                          increase: true,
                        );
                      }
                    );
                  },
                ),
                DebtorActionButton(
                  title: "ask".tr,
                  icon: Icons.keyboard_arrow_up_outlined,
                  color: Colors.lightGreen,
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (con){
                        if(phoneNumber.isEmpty || phoneNumber.length < 8){
                          return ErrorDialog(message: 'no_phone'.tr);
                        }else{
                          return AskDialog(phoneNumber: phoneNumber,debtorName: debtorName,money: model.debt.toInt().toString(),);
                        }
                      }
                    );
                  },
                ),
                DebtorActionButton(
                  title: "settle".tr,
                  icon: Icons.payments_sharp,
                  color: Colors.grey,
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (con){
                        return SettleDialog(debtId: model.id, debtorId: model.debtorId);
                      }
                    );
                  },
                ),
                DebtorActionButton(
                  title: "delete".tr,
                  icon: Icons.delete,
                  color: Colors.red,
                  onTap: (){
                    Get.defaultDialog(
                      title: '',
                      content: Container(
                        child: Column(
                          children: [
                            Text('delete'.tr),
                            Text('do you really want to delete this debt'),
                          ],
                        ),
                      ),
                      confirm: MainButton(
                        title: 'delete'.tr,
                        color: Colors.red,
                        width: double.infinity,
                        onTap: () async{
                          Get.back();
                          await debtsController.deleteDebt(model.id);
                          await debtorController.deleteDebtor(model.debtorId);
                          Get.defaultDialog(
                            title: '',
                            content: Center(child: CircularProgressIndicator(color: AppColors.mainAppColor,),)
                          );

                          Get.back();
                          Get.back();
                          Get.showSnackbar(GetSnackBar(
                            duration: Duration(seconds: 4),
                            margin: EdgeInsets.symmetric(vertical: 0,horizontal: 8),
                            padding: EdgeInsets.all(8),
                            message: "Successfully deleted",
                            borderRadius: 7,
                            icon: Container(height: 60,width: 50,child: Icon(Icons.check_circle,color:  Theme.of(context).colorScheme.primary,size: 30,)),
                            backgroundColor: Colors.green,
                          ));
                        }
                      ),
                      cancel: MainButton(
                        title: 'cancel'.tr,
                        color: Colors.grey.shade500,
                        width: double.infinity,
                        onTap: (){
                          Get.back();
                        }
                      )
                    );
                  },
                ),
              ]
          ),
        ),
      ),
    );
  }
}
