import 'package:collect/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class SwitchSettings extends StatelessWidget {
  const SwitchSettings({super.key,required this.value,required this.title,required this.subTitle,this.onChanged});
  final bool value;
  final String title;
  final String subTitle;
  final void Function(bool val)? onChanged;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Material(
      color: Colors.transparent,
      child: SwitchListTile(
        activeThumbColor: AppColors.mainAppColor,
        value: value,
        onChanged: onChanged,
        secondary: Container(
          width:  isPortrait ? appSizes.height * 0.06 : appSizes.width * 0.06,
          height: isPortrait ? appSizes.height * 0.06 : appSizes.width * 0.06,
          decoration: BoxDecoration(
              color: Colors.green.withAlpha(40),
              borderRadius: BorderRadius.circular(11)
          ),
          child: Icon(Icons.dark_mode_outlined,size: isPortrait ? appSizes.height * 0.035 : appSizes.width * 0.035 ,color: Colors.green,),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,textScaler: TextScaler.linear(1),style: TextStyle(fontWeight: FontWeight.bold,fontSize: isPortrait ? appSizes.height * 0.018 : appSizes.width * 0.018),),
            Text(subTitle,textScaler: TextScaler.linear(1),style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.012 : appSizes.width * 0.012,color: Colors.grey),),
          ],
        ),
      ),
    );
  }
}
