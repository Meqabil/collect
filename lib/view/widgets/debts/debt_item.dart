import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/functions/day_date_format.dart';
import 'package:collect/core/security/encryption_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../controller/debtors/debtor_controller.dart';
import '../../../data/models/debtors/debtor_model.dart';


class DebtItem extends StatelessWidget {
  const DebtItem({
    super.key,
    required this.clientId,
    required this.type,
    required this.date,
    required this.debt,
    this.onTap,
    this.color,
  });
  final DateTime date;
  final String clientId;
  final String type;
  final String debt;
  final Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    DebtorControllerImpl debtorController = Get.find();
    AppSizes appSizes = AppSizes(context: context);
    bool loaded = false;
    return InkWell(
      onTap: onTap,
      child: GetBuilder<DebtorControllerImpl>(
        builder: (context) {
          return FutureBuilder<DebtorModel>(
            future: debtorController.getDebtor(clientId),
            builder: (context, asyncSnapshot) {
              final debtor = asyncSnapshot.data;
              if(asyncSnapshot.connectionState == ConnectionState.waiting){
                loaded = false;
              }
              if(asyncSnapshot.connectionState == ConnectionState.done){
                loaded = true;
              }
              return Container(
                margin: EdgeInsets.symmetric(vertical: appSizes.height * 0.004,horizontal: appSizes.height * 0.002),
                padding: EdgeInsets.symmetric(vertical: appSizes.height * 0.005,horizontal: appSizes.height * 0.008),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        SizedBox(
                          width: appSizes.width / 4,
                            child: Text(loaded ? "${debtor?.name} " : "Name",style: TextStyle(fontSize: appSizes.height * 0.0157,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: appSizes.height * 0.008,vertical: appSizes.height * 0.003),
                          decoration: BoxDecoration(
                              color: Colors.deepPurple.withAlpha(40),
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: FutureBuilder(
                            future: CipherService.decrypt(type) ,
                            builder: (con,asy){
                              if(asy.connectionState == ConnectionState.done){
                                String? type =  asy.data ?? '';
                                print(asy.data);
                                return Text(' ${type == '' ? '' : type.tr} ',style: TextStyle(fontSize: appSizes.height * 0.012,color: Colors.deepPurple,));
                              }
                              return Text('type'.tr);
                            }
                          )
                          ),
                        Row(
                          spacing: 5,
                          children: [
                            Icon(Icons.call,size: appSizes.height * 0.0145,color: Colors.grey,),
                            Text(loaded ? (debtor?.phone == '' ? '' : debtor?.phone ?? '') : "phone number",style: TextStyle(fontSize: appSizes.height * 0.014,color: Colors.grey),),
                          ],
                        )
                      ],
                    ),
                    SizedBox(width: appSizes.height * 0.002,height: appSizes.height * 0.05,child: VerticalDivider(thickness: 0.4,)),
                    //SizedBox(width: 25,height: 50,child: VerticalDivider(thickness: 0.4,)),
                    Column(
                      children: [
                        Row(
                          spacing: 5,
                          children: [
                            Icon(Icons.calendar_month,color: Color(0xFF1b8554),size: 15,),
                            Text(date.toString().substring(0,10),style: TextStyle(fontSize: 13),),
                          ],
                        ),
                        Text(dayDateFormat(date),style: TextStyle(color: color,fontSize: 10),),
                      ],
                    ),
                    SizedBox(width: appSizes.height * 0.002,height: appSizes.height * 0.05,child: VerticalDivider(thickness: 0.4,)),
                    Column(
                      children: [
                        Text(double.parse(debt).toInt().toString(),style: TextStyle(color: color,fontSize: appSizes.height * 0.016,fontWeight: FontWeight.bold),),
                        Text("rest".tr,style: TextStyle(fontSize: appSizes.height * 0.014),)
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_outlined,size: appSizes.height * 0.015,)
                  ],
                ),
              );
            }
          );
        }
      ),
    );
  }
}
