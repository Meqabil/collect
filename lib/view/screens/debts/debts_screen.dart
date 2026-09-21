import 'package:collect/controller/debts/debts_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/view/screens/debts/debt_options_view.dart';
import 'package:collect/view/screens/debts/debt_screen.dart';
import 'package:collect/view/screens/debts/money_board_view.dart';
import 'package:collect/view/widgets/debts/debt_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../core/constants/assets/app_images.dart';

class DebtsScreen extends StatelessWidget {
  const DebtsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    DebtsControllerImpl controller = Get.find();
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("collect".tr,style: TextStyle(fontWeight: FontWeight.bold,)),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        child: Column(
          children: [
            MoneyBoardView(),
            SizedBox(height: appSizes.height * .015,),
            DebtOptionsView(),
            SizedBox(height: appSizes.height * 0.014,),
            GetBuilder<DebtsControllerImpl>(
              builder: (context) {
                String tempOp = 'all';
                if(controller.option == DebtOptions.payed){
                  tempOp = "payed";
                }else if(controller.option == DebtOptions.nearly){
                  tempOp = "nearly";
                }else if(controller.option == DebtOptions.dueToday){
                  tempOp = "due";
                }else if(controller.option == DebtOptions.late){
                  tempOp = "late";
                }
                return Expanded(
                  child: RefreshIndicator(
                    color: Colors.green,
                    onRefresh: () async{
                      await controller.getDebtsForAll(tempOp);
                    },
                    child: FutureBuilder(
                      future: controller.getDebtsForAll(tempOp),
                      builder: (context,snap) {
                        if(snap.connectionState == ConnectionState.done){
                          if(controller.debtsList.isEmpty){
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  isPortrait || (!isPortrait && appSizes.height > 600) ? Image.asset(
                                    width: appSizes.width / 2.5,
                                    AppImages.noDebts
                                  ) : Container(),
                                  Text('no_debts_yet'.tr,style: TextStyle(fontSize: isPortrait ? appSizes.height * .022 : appSizes.width * 0.018,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: controller.debtsList.length,
                            itemBuilder: (context,idx){
                              int comDate = DateTime(controller.debtsList[idx].nextDate.year,controller.debtsList[idx].nextDate.month,controller.debtsList[idx].nextDate.day).compareTo(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,));
                              return GetBuilder<DebtsControllerImpl>(
                                builder: (context) {
                                  return DebtItem(
                                    clientId: controller.debtsList[idx].debtorId,
                                    type: controller.debtsList[idx].type,
                                    date: controller.debtsList[idx].nextDate,
                                    debt: controller.debtsList[idx].debt.toString(),
                                    color: comDate == 1 ? Colors.green : comDate == 0 ? Colors.orange : Colors.red,
                                    onTap: (){
                                      Get.to(() => DebtScreen(
                                        model: controller.debtsList[idx],
                                      ));
                                    },
                                  );
                                }
                              );
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator(),);
                      }
                    ),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
