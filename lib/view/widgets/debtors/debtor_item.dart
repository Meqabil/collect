import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/constants/assets/app_images.dart';
import 'package:collect/core/functions/day_date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/debts/debts_controller.dart';
import '../../../data/models/debts/debt_model.dart';

class DebtorItem extends StatelessWidget {
  const DebtorItem({
    super.key,
    required this.debtorId,
    required this.clientName,
    required this.type,
    this.onTap

  });
  final String debtorId;
  final String clientName;
  final String type;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    DebtsControllerImpl debtController = Get.find();
    AppSizes appSizes = AppSizes(context: context);
    bool loaded = false;
    Color? color;
    return FutureBuilder<DebtModel>(
        future: debtController.getDebt(debtorId),
        builder: (context, asyncSnapshot) {
          DebtModel? debts;
          int comDate = 0;
          if(asyncSnapshot.connectionState == ConnectionState.waiting){
            loaded = false;
          }
          if(asyncSnapshot.connectionState == ConnectionState.done){
            debts = asyncSnapshot.data;
            loaded = true;
            comDate = DateTime(debts!.nextDate.year,debts.nextDate.month,debts.nextDate.day).compareTo(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,));
            if(comDate == 1){
              color = Colors.green;
            }else if(comDate == -1){
              color = Colors.red;
            }else{
              color = Colors.orange;
            }
          }
          return InkWell(
            onTap: onTap,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4,horizontal: 2),
              padding: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(width: 4,color: color ?? Colors.white)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(33),
                      blurRadius: 35,
                      spreadRadius: 0,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Colors.black.withAlpha(22),
                      blurRadius: 15,
                      spreadRadius: -2,
                      offset: const Offset(0, 2),
                    ),
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 15,
                children: [
                  CircleAvatar(backgroundImage: AssetImage(AppImages.avatar),radius: 30,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      SizedBox(
                          width: appSizes.width / 3,
                          child: Text(clientName,style: TextStyle(fontSize: appSizes.height * 0.016,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: appSizes.height * 0.01,vertical: appSizes.height * 0.004),
                        decoration: BoxDecoration(
                            color: type == "personal" ? Colors.deepPurple.withAlpha(40) : Colors.blue.withAlpha(40),
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: Text(' ${type.tr} ',style: TextStyle(fontSize: appSizes.height * 0.012,color: type == "personal" ? Colors.deepPurple : Colors.blue,)),
                      ),
                      Row(
                        spacing: 6,
                        children: [
                          Text("${'rest'.tr} ",style: TextStyle(fontSize: appSizes.height * 0.014),),
                          Text(loaded ? double.parse(debts!.debt.toString()).toInt().toString() : "debt",style: TextStyle(color: color,fontSize: appSizes.height * 0.014,fontWeight: FontWeight.bold),),
                          Text("${'l.e'.tr} ",style: TextStyle(fontSize: appSizes.height * 0.012),),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  SizedBox(width: appSizes.width / 5.2,child: Text(dayDateFormat(loaded ? debts!.nextDate : DateTime.now()),textAlign: TextAlign.center,style: TextStyle(color: color,fontSize: appSizes.height * 0.01,overflow: TextOverflow.fade),)),
                  SizedBox(width: appSizes.height * 0.001,),
                ],
              ),
            ),
          );
        }
    );
  }
}
