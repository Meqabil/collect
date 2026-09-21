import 'package:collect/controller/debtors/debtor_controller.dart';
import 'package:collect/core/constants/assets/app_images.dart';
import 'package:collect/core/theme/app_colors.dart';
import 'package:collect/view/widgets/debtors/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../controller/debts/debts_controller.dart';
import '../../../core/constants/app_sizes.dart';


class DebtorReviseScreen extends StatelessWidget {
  const DebtorReviseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    DebtsControllerImpl controller = Get.find();
    DebtorControllerImpl debtorController = Get.find();
    Uuid uuid = Uuid();
    return SingleChildScrollView(
      child: Container(
        width: appSizes.width,
        height: !isNotPhone ? isPortrait ?  appSizes.height * .7 : appSizes.height * 1.6 : appSizes.height * .9,
        padding: EdgeInsets.symmetric(horizontal: appSizes.height * 0.01,vertical: appSizes.height * 0.01),
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            Text("debtor_details".tr,style: TextStyle(fontSize: isNotPhone ? appSizes.height * 0.018 : appSizes.width * 0.018,fontWeight: FontWeight.bold),),
            Container(
              width: appSizes.width,
              height: !isNotPhone && isPortrait ? appSizes.height / 8 : appSizes.width / 7,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    spreadRadius: 1.2,
                    blurRadius: 1.5
                  )
                ]
              ),
              child: Row(
                children: [
                  SizedBox(width: 25,),
                  CircleAvatar(
                    backgroundImage: AssetImage(AppImages.avatar),
                    radius: !isNotPhone && isPortrait ? appSizes.height * 0.05 : appSizes.width * 0.05,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(debtorController.nameController.text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withAlpha(65),
                          borderRadius: BorderRadius.circular(6)
                        ),
                        child: Text(debtorController.category,style: TextStyle(fontSize: 8,),),
                      ),
                      Row(
                        spacing: 2,
                        children: [
                          Icon(Icons.call,size: 11,color: AppColors.mainAppColor,),
                          Text(debtorController.phoneController.text,style: TextStyle(fontSize: 9),)
                        ],
                      ),
                      Row(
                        spacing: 2,
                        children: [
                          Icon(Icons.location_on,size: 11,color: AppColors.mainAppColor,),
                          Text(debtorController.addressController.text,style: TextStyle(fontSize: 9),)
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Text("debt_details".tr,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
            Expanded(
              child: Container(
                width: appSizes.width,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withAlpha(50),
                        spreadRadius: 1.2,
                        blurRadius: 1.5
                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("total_debt_value".tr,style: TextStyle(color: Colors.grey.shade600),),
                        Spacer(),
                        Text(controller.totalDebtController.text,style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text("debt_type".tr,style: TextStyle(color: Colors.grey.shade600),),
                        Spacer(),
                        Text(debtorController.category.tr,style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text("payment_method".tr,style: TextStyle(color: Colors.grey.shade600),),
                        Spacer(),
                        Text(controller.type.tr,style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text("number_of_installments".tr,style: TextStyle(color: Colors.grey.shade600),),
                        Spacer(),
                        Text(controller.numOfInstallmentsController.text,style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text("first_debt_date".tr,style: TextStyle(color: Colors.grey.shade600),),
                        Spacer(),
                        Text(controller.nextDate.toString().substring(0,10),style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Divider(),

                    Text("notes".tr,style: TextStyle(color: Colors.grey.shade600),),
                    Text(debtorController.notesController.text,style: TextStyle(color: Colors.grey.shade600,fontSize: 11),),
                    Spacer(),
                    Row(
                      children: [
                        MainButton(
                          title: "back".tr,
                          width: appSizes.width / 2.8,
                          color: Colors.grey,
                          onTap: (){
                            debtorController.pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.ease);
                          },
                        ),
                        Spacer(),
                        MainButton(
                          title: "add_debtor".tr,
                          width: appSizes.width / 2.6 ,
                          onTap: () async{
                            if(controller.totalDebtController.text.isEmpty || debtorController.nameController.text.isEmpty){
                              Get.showSnackbar(
                                GetSnackBar(
                                  title: 'error'.tr,
                                  message: 'Make sure you added name, and debt money',
                                  backgroundColor: Colors.red,
                                  icon: Icon(Icons.error,color: Colors.white,),
                                  duration: Duration(seconds: 4),
                                )
                              );

                            }else{
                              String id = uuid.v4();
                              debtorController.addDebtor(
                                id: id,
                                name: debtorController.nameController.text.trim(),
                                phoneNumber: debtorController.phoneController.text.trim(),
                                address: debtorController.addressController.text.trim(),
                                note: debtorController.notesController.text.trim(),
                              );
                              controller.addDebt(
                                debtorId: id,
                                totalDebt: double.parse(controller.totalDebtController.text.trim()),
                                valueOfFirstOfInstallment: double.parse(controller.valueOfInstallmentController.text.trim() == '' ? '0' : controller.valueOfInstallmentController.text.trim()),
                                numOfInstallments : int.parse(controller.numOfInstallmentsController.text.trim() == '' ? '0' : controller.numOfInstallmentsController.text.trim())
                              );
                              controller.clear();
                              debtorController.clear();
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
                              await Future.delayed(Duration(seconds: 1),);
                              controller.clear();
                              Get.back();
                              Get.back();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
