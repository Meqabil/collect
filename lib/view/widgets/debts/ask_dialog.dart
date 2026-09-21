import 'package:collect/controller/settings/ask_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/constants/assets/app_images.dart';
import 'package:collect/core/constants/lists.dart';
import 'package:collect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../debtors/main_button.dart';

class AskDialog extends StatelessWidget {
  const AskDialog({super.key,required this.phoneNumber,required this.debtorName,required this.money});
  final String phoneNumber;
  final String debtorName;
  final String money;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    AskControllerImpl controller = Get.put(AskControllerImpl());
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25,horizontal: 12),
          width: appSizes.width / 1,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              Material(
                color: Colors.transparent,
                child: ListTile(
                  title: Text('whatsapp'.tr),
                  subtitle: Text('send_direct_message'.tr,style: TextStyle(color: Colors.grey.shade500),),
                  leading: Image.asset(AppImages.whatsapp,width: 40,),
                  onTap: (){
                    controller.changeType("whatsapp");
                  },
                ),
              ),
              Material(
                color: Colors.transparent,
                child: ListTile(
                  title: Text('call'.tr),
                  subtitle: Text('send_direct_message'.tr,style: TextStyle(color: Colors.grey.shade500),),
                  leading: Image.asset(AppImages.whatsapp,width: 40,),
                  onTap: (){
                    controller.changeType("call");
                    controller.contactUs(number: phoneNumber);
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: GetBuilder<AskControllerImpl>(
                  builder: (context) {
                    if(controller.type == 'call'){
                      return Container();
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: contextsContents.length,
                      itemBuilder: (con,idx){
                        if(contextsContents[idx] == ''){
                          return Container();
                        }
                        return InkWell(
                          onTap: (){
                            controller.changeOption(idx);
                            controller.sendUsOnWhatsApp(phone: phoneNumber, message: contextsContents[idx],debtorName: debtorName,money: money);
                            Get.back();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(4),
                            width:  35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: controller.option == idx ? AppColors.mainAppColor : Theme.of(con).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10),
                              border: BoxBorder.all(width: 1,color: AppColors.mainAppColor)
                            ),
                            child: Text((idx + 1).toString(), style: TextStyle(color: controller.option == idx ? Colors.white : AppColors.mainAppColor),),
                          ),
                        );
                      },
                    );
                  }
                ),
              ),

              MainButton(
                title: "cancel".tr,
                width: appSizes.width,
                color: Colors.grey,
                onTap: (){
                  Get.back();
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

