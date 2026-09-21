import 'package:collect/controller/debtors/debtor_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/view/widgets/debtors/calendar_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/debts/debts_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/debtors/debtor_input.dart';
import '../../widgets/debtors/dialog_date.dart';
import '../../widgets/debtors/main_button.dart';

class DebtDetailsScreen extends StatefulWidget {
  const DebtDetailsScreen({super.key});

  @override
  State<DebtDetailsScreen> createState() => _DebtDetailsScreenState();
}

class _DebtDetailsScreenState extends State<DebtDetailsScreen> {
  PageController secondaryPageController = PageController();
  int pageNumber = 0;
  String pay = 'one';

  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    DebtsControllerImpl controller = Get.find();
    DebtorControllerImpl debtorController = Get.find();
    return SingleChildScrollView(
      child: Container(
        width: appSizes.width,
        height: isPortrait ? appSizes.height *.8 : appSizes.height,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          children: [
            SizedBox(
              width: appSizes.width,
              height: appSizes.height / 1.6 - 10,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("debt_details".tr,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),

                    DebtorInput(
                      label: "total_debt_value".tr,
                      hint: "500,000",
                      controller: controller.totalDebtController,
                      required: true,
                      numbersOnly: true,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "field_not_empty".tr;
                        }
                        return null;
                      },
                    ),

                    Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("payment_method".tr),
                        RadioGroup(
                          groupValue: pay,
                          onChanged: (v){
                            pay = v ?? 'one';
                            if(pay == 'one'){
                              secondaryPageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.ease);
                            }else{
                              secondaryPageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.ease);
                            }
                            setState(() {});
                          },
                          child: Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  secondaryPageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.ease);
                                  controller.updateType('one_time');
                                },
                                child: Container(
                                  width: appSizes.width / 2 - 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(width: pageNumber == 0 ? 1.4 : 0.7,color: pageNumber == 0 ? AppColors.mainAppColor : Colors.black)
                                  ),
                                  child: Row(
                                    children: [
                                      Radio(value: 'one',activeColor: AppColors.mainAppColor,),
                                      Text('one_time'.tr,),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  secondaryPageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.ease);
                                  controller.updateType('deferred');
                                },
                                child: Container(
                                  width: appSizes.width / 2 - 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(width:  pageNumber == 1 ? 1.4 : .7,color: pageNumber == 1 ? AppColors.mainAppColor : Colors.black)

                                  ),
                                  child: Row(
                                    children: [
                                      Radio(value: 'parts',activeColor: AppColors.mainAppColor,),
                                      Text('deferred'.tr),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: isPortrait && !isNotPhone ? appSizes.height / 3.5 : isNotPhone ? appSizes.height / 3 : appSizes.height,
                      width: appSizes.width,
                      child: PageView(
                        controller: secondaryPageController,
                        onPageChanged: (page){
                          pageNumber = page;
                          if(page == 0){
                            pay = 'one';
                          }else{
                            pay = 'parts';
                          }
                          setState(() {

                          });
                        },
                        children: [
                          Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text('first_debt_date'.tr,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                            GetBuilder<DebtsControllerImpl>(
                              builder: (con) {
                                return CalendarButton(
                                  title: controller.nextDate.toString().substring(0,10),
                                  color: AppColors.mainAppColor,
                                  onTap: (){
                                    showDialog(
                                      context: context,
                                      builder: (context){
                                        return DialogDate(
                                          initialDate: controller.nextDate,
                                          onChangeDate: (v){
                                            controller.choseNextDate(v);
                                            Get.back();
                                          },
                                        );
                                      }
                                    );
                                  }
                                );
                              }
                            ),
                           ],
                        ),
                          Column(
                            spacing: 5,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('first_debt_date'.tr,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                              GetBuilder<DebtsControllerImpl>(
                                builder: (con) {
                                  return CalendarButton(
                                    title: controller.nextDate.toString().substring(0,10),
                                    color: AppColors.mainAppColor,
                                    onTap: (){
                                      showDialog(
                                        context: context,
                                        builder: (context){
                                          return DialogDate(
                                            initialDate: controller.nextDate,
                                            onChangeDate: (v){
                                              controller.choseNextDate(v);
                                              Get.back();
                                            },
                                          );
                                        }
                                      );
                                    }
                                  );
                                }
                              ),
                              pageNumber == 1 ? DebtorInput(controller: controller.numOfInstallmentsController,hint: "3", label: "number_of_installments".tr, required: false) : Container(),
                              pageNumber == 1 ? DebtorInput(controller: controller.valueOfInstallmentController,hint: "35,000 ${'l.e'.tr}", label: "value_of_first_installment".tr, required: false) : Container(),
                            ],
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                MainButton(
                  title: "back".tr,
                  width: appSizes.width / 2.5,
                  color: Colors.grey,
                  onTap: (){
                    debtorController.pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.ease);
                  },
                ),
                Spacer(),
                MainButton(
                  title: "next".tr,
                  width: appSizes.width / 2.5 ,
                  onTap: (){
                    if(debtorController.key.currentState!.validate()){
                      debtorController.pageController.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.ease);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
