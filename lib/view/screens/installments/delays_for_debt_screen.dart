import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/functions/day_date_format.dart';
import 'package:collect/data/models/installments/delay_model.dart';
import 'package:collect/view/widgets/debtors/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/assets/app_images.dart';
import '../../../core/functions/month_date_format.dart';
import '../../../controller/installments/installments_controller.dart';

class DelaysForDebtScreen extends StatelessWidget {
  const DelaysForDebtScreen({super.key,required this.debtorId});
  final String debtorId;
  @override
  Widget build(BuildContext context) {
    InstallmentsControllerImpl controller = Get.find();
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return GetBuilder<InstallmentsControllerImpl>(
      builder: (context){
        return FutureBuilder(
          future: controller.getAllDelaysForDebt(debtorId),
          builder: (context, snap) {
            if(snap.connectionState == ConnectionState.done){
              final List<DelayModel> data = snap.data ?? [];
              if(data.isEmpty){
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isPortrait || (!isPortrait && appSizes.height > 600) ? Image.asset(
                          width: appSizes.width / 2.5,
                          AppImages.noDelays
                      ) : Container(),
                      Text('no_delays_for_debt'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (con,idx){
                  return InkWell(
                    onLongPress: (){
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
                                  Text("delete_delay".tr),
                                  Spacer(),
                                  MainButton(
                                    title: "yes".tr,
                                    width: 300,
                                    color: Colors.red,
                                    onTap: (){
                                      controller.deleteDelay(data[idx].id,debtorId);
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
                          Icon(Icons.access_time_rounded, color: Colors.orange,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("reason".tr),
                              SizedBox(width: appSizes.width / 3,child: Text(data[idx].reason.toString().tr,overflow: TextOverflow.ellipsis,)),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                            decoration: BoxDecoration(
                                color: Colors.red.withAlpha(40),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: Text('delayed'.tr,style: TextStyle(fontSize: 11,color: Colors.red,)),
                          ),
                          Column(
                            children: [
                              Text(dayDateFormat(data[idx].delayedTo),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.orange),),
                              Text(monthDateFormat(data[idx].delayedTo),style: TextStyle(fontSize: 12),),
                            ],
                          ),
                        ],
                      ),
                    ),
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
