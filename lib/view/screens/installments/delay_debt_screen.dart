import 'package:collect/controller/debtors/debtor_controller.dart';
import 'package:collect/controller/debts/debts_controller.dart';
import 'package:collect/controller/installments/installments_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/theme/app_colors.dart';
import 'package:collect/core/functions/day_date_format.dart';
import 'package:collect/view/widgets/debtors/calendar_button.dart';
import 'package:collect/view/widgets/debtors/dialog_date.dart';
import 'package:collect/view/widgets/debtors/main_button.dart';
import 'package:collect/view/widgets/shared/text_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class DelayDebtScreen extends StatelessWidget {
  const DelayDebtScreen({super.key,required this.debtOrInstallment,required this.debtorName,required this.debtorId,required this.debtId,required this.date});
  final String debtOrInstallment;
  final String debtorName;
  final String debtId;
  final String debtorId;
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    InstallmentsControllerImpl controller = Get.find();
    DebtsControllerImpl debtsController = Get.find();
    DebtorControllerImpl debtorController = Get.find();
    int comp = date.compareTo(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,));

    return Scaffold(
      appBar: AppBar(
        title: Text("delay_pay".tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: appSizes.width,
          height: !isNotPhone && isPortrait ? appSizes.height - 80 :  appSizes.width / 1.25,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            spacing: 10,
            children: [
              Container(
                width: appSizes.width,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                child: Row(
                  children: [
                    SizedBox(width: 15,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Text("$debtorName ",style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.0175 : appSizes.width * 0.0175,fontWeight: FontWeight.bold,color: AppColors.mainAppColor),),
                        Text("$debtOrInstallment  ُ${'l.e'.tr}",style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.015 : appSizes.width * 0.015,fontWeight: FontWeight.bold),),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2,horizontal: 4),
                          color: comp == -1 ? Colors.red.withAlpha(40) : comp == 1 ? Colors.green.withAlpha(40) : Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Icon(Icons.calendar_today,size: isPortrait ? appSizes.height * .01 : appSizes.width * 0.01,color: comp == -1 ? Colors.red : comp == 1 ? Colors.green : Colors.grey,),
                              Text(dayDateFormat(date).toString().tr,style: TextStyle(color: comp == -1 ? Colors.red : comp == 1 ? Colors.green : Colors.grey,fontSize: isPortrait ? appSizes.height * .012 : appSizes.width * 0.012),)
                            ],
                          ),
                        ),
                      ],
                    )
                  ]
                ),
              ),
               Expanded(
                 child: Container(
                  width: appSizes.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 11,
                      children: [
                        Text("reason".tr,style: TextStyle(fontWeight: FontWeight.bold),),
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
                                value: controller.option,
                                style: TextStyle(color: Colors.grey.shade600),
                                items: controller.excuses.map(
                                        (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e.toString().tr),
                                    )
                                ).toList() ,
                                onChanged: (v){
                                  controller.updateOption(v ?? controller.option);
                                },
                              );
                            }
                          ),
                        ),
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
                                items: controller.means.map(
                                        (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e.toString().tr),
                                    )
                                ).toList() ,
                                onChanged: (v){
                                  controller.updateMean(v ?? controller.contact);
                                },
                              );
                            }
                          ),
                        ),
                        Text("new_date".tr,style: TextStyle(fontWeight: FontWeight.bold),),
                        GetBuilder<InstallmentsControllerImpl>(
                          builder: (con){
                            return CalendarButton(
                              title: controller.debtDate.toString().substring(0,10),
                              color: Colors.white,
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (context){
                                    return DialogDate(
                                      initialDate: controller.debtDate,
                                      onChangeDate: (date){
                                        controller.changeDate(date);
                                        debtsController.update();
                                        Get.back();
                                      },
                                    );
                                  }
                                );
                              }
                            );
                          },
                        ),
                        Text("notes".tr,style: TextStyle(fontWeight: FontWeight.bold),),
                        TextArea(text: "write_any_notes".tr, controller: controller.notesController),
                      ],
                    ),
                  ),
                 ),
               ),
               MainButton(
                 color: AppColors.mainAppColor,
                 title: "delay".tr,
                 width: appSizes.width ,
                 onTap: () async{
                   controller.delayInstallment(
                     debtId: debtId,
                     debtorId: debtorId,
                     debt: debtOrInstallment,
                     note: controller.notesController.text.trim(),
                     reason: controller.option,
                     meanOfContact:controller.contact,
                     delayedFrom: date,
                     delayedTo: controller.debtDate
                   );
                   debtsController.clear();
                   debtorController.clear();
                   Get.back();
                   Get.back();
                 }
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
