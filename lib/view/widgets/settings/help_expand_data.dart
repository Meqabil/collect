import 'package:collect/controller/theme/theme_controller.dart';
import 'package:collect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class HelpExpandData extends StatelessWidget {
  const HelpExpandData({super.key,required this.item});
  final Map<String,String> item;
  @override
  Widget build(BuildContext context) {
    ThemeControllerImpl controller = Get.put(ThemeControllerImpl());
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text(item['question'].toString()),
        iconColor: AppColors.mainAppColor,

        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 11),
            //padding: EdgeInsets.only(left: width * 0.045,right: width * 0.022,top: width * 0.022,bottom: width * 0.022),
            decoration: BoxDecoration(
                color: controller.isDarkMode.value ? Colors.green :  AppColors.lightGreen,
            ),
            child: Text(item['answer'] ?? '', style: TextStyle(fontSize: 13)),
          )
        ],
      )
    );
  }
}
