import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/data/models/installments/increases_or_decreases_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../controller/installments/installments_controller.dart';
import '../../../core/constants/assets/app_images.dart';
import '../../../core/functions/month_date_format.dart';
import '../../widgets/debtors/main_button.dart';

class DebtChangesScreen extends StatelessWidget {
  const DebtChangesScreen({super.key,required this.debtorId});
  final String debtorId;
  @override
  Widget build(BuildContext context) {
    InstallmentsControllerImpl controller = Get.find();
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return GetBuilder<InstallmentsControllerImpl>(
      builder: (context){
        return FutureBuilder(
            future: controller.getAllChangesInDebt(debtorId),
            builder: (context, snap) {
              if(snap.connectionState == ConnectionState.done){
                final List<IncreasesOrDecreasesModel> data = snap.data ?? [];
                if(data.isEmpty){
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isPortrait || (!isPortrait && appSizes.height > 600) ? Image.asset(
                          width: appSizes.width / 2,
                          AppImages.noChanges
                        ) : Container(),
                        Text('no_debt_changes'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
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
                                      title: "Yes",
                                      width: 300,
                                      color: Colors.red,
                                      onTap: (){
                                        controller.deleteChangeInDebt(data[idx].id,debtorId);
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: data[idx].type == "increase" ? Colors.blue.withAlpha(40) : Colors.red.withAlpha(40),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Icon(data[idx].type == "increase" ? Icons.arrow_upward : Icons.arrow_downward ,color: data[idx].type == "increase" ? Colors.blue : Colors.red, )
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                  decoration: BoxDecoration(
                                      color: data[idx].type == "increase" ? Colors.blue.withAlpha(40) : Colors.red.withAlpha(40),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Text(data[idx].type.tr,style: TextStyle(fontSize: 11,color: data[idx].type == "increase" ? Colors.blue : Colors.red,)),
                                ),
                                Column(
                                  children: [
                                    Text(data[idx].installment.toInt().toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: data[idx].type == "increase" ? Colors.blue : Colors.red,),),
                                    Text(monthDateFormat(data[idx].createdAt,),style: TextStyle(fontSize: 12),),
                                  ],
                                ),
                              ],
                            ),
                            data[idx].note == '' ? Container() : SizedBox(height: 15,),
                            data[idx].note == '' ? Container() : Row(
                              spacing: 10,
                              children: [
                                Icon(Icons.info,color: Colors.orange,size: 15,),
                                Text(data[idx].note)
                              ],
                            )
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
