import 'package:collect/controller/installments/installments_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/theme/app_colors.dart';
import 'package:collect/core/functions/month_date_format.dart';
import 'package:collect/data/models/installments/installment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/assets/app_images.dart';
import '../../widgets/debtors/main_button.dart';

class InstallmentsScreen extends StatefulWidget {
  const InstallmentsScreen({super.key,required this.debtorId});
  final String debtorId;

  @override
  State<InstallmentsScreen> createState() => _InstallmentsScreenState();
}

class _InstallmentsScreenState extends State<InstallmentsScreen> {
  int settled = 0;
  @override
  Widget build(BuildContext context) {
    InstallmentsControllerImpl controller = Get.find();
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return GetBuilder<InstallmentsControllerImpl>(
      builder: (context){
        return FutureBuilder(
          future: controller.getAllInstallments(widget.debtorId),
          builder: (context, snap) {
            if(snap.connectionState == ConnectionState.done){
              final List<InstallmentModel> data = snap.data ?? [];
              if(data.isEmpty){
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isPortrait || (!isPortrait && appSizes.height > 600) ? Image.asset(
                        width: appSizes.width / 2.5,
                        AppImages.noInstallments
                      ) : Container(),
                      Text('no_installment_payed_yet'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (con,idx){
                  if(data[idx].nextDate.year == 2100){
                    settled = 1;
                    controller.getAllInstallments(widget.debtorId);
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.5,color: Colors.grey),
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.money_off_csred_sharp,color: Colors.blue,),
                          Text(data[idx].installment.toInt().toString()),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue.withAlpha(40),
                              borderRadius: BorderRadius.circular(6)
                            ),
                            child: Text(" ${'settlement'.tr} ",style: TextStyle(fontSize: 11,color: Colors.blue,)),
                          ),
                          Column(
                            children: [
                              Text(data[idx].installment.toInt().toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.blue),),
                              Text(monthDateFormat(data[idx].createdAt,),style: TextStyle(fontSize: 12),),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  return FutureBuilder(
                    future: controller.hasSettled(widget.debtorId),
                    builder: (context, snap) {
                      if(snap.connectionState == ConnectionState.done) {
                        final bool settled = snap.data ?? false;
                        return InkWell(
                          onLongPress: settled ? null : (){
                            showDialog(
                              context: context,
                              builder: (con){
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: SizedBox(
                                    width: 300,
                                    height: 150,
                                    child: Column(
                                      children: [
                                        Text("delete_installment".tr),
                                        Spacer(),
                                        MainButton(
                                          title: "yes".tr,
                                          width: 300,
                                          color: Colors.red,
                                          onTap: (){
                                            controller.deleteInstallment(data[idx].id,widget.debtorId);
                                            Get.back();
                                          }
                                        ),
                                        MainButton(
                                          title: "cancel".tr,
                                          width: 300,
                                          color: Colors.grey,
                                          onTap: (){
                                            Get.back();
                                          }
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 0.5,color: Colors.grey),
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.monetization_on,color: AppColors.mainAppColor,),
                                Text(data[idx].installment.toInt().toString()),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                  decoration: BoxDecoration(
                                      color: AppColors.mainAppColor.withAlpha(40),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Text('payed'.tr,style: TextStyle(fontSize: 11,color: AppColors.mainAppColor,)),
                                ),
                                Column(
                                  children: [
                                    Text(data[idx].installment.toInt().toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.green),),
                                    Text(monthDateFormat(data[idx].createdAt,),style: TextStyle(fontSize: 12),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 0.5,color: Colors.grey),
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.monetization_on,color: AppColors.mainAppColor,),
                            Text(data[idx].installment.toInt().toString()),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                              decoration: BoxDecoration(
                                  color: AppColors.mainAppColor.withAlpha(40),
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              child: Text('payed'.tr,style: TextStyle(fontSize: 11,color: AppColors.mainAppColor,)),
                            ),
                            Column(
                              children: [
                                Text(data[idx].installment.toInt().toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.green),),
                                Text(monthDateFormat(data[idx].createdAt,),style: TextStyle(fontSize: 12),),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator(),);
          }
        );
      },
    );
  }
}
