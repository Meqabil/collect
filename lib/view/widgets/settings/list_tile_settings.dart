import 'package:collect/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';


class ListTileSettings extends StatelessWidget {
  const ListTileSettings({super.key,required this.title,required this.subTitle,required this.trailingText,required this.icon,this.onTap});

  final String title;
  final String subTitle;
  final String trailingText;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width:  isPortrait ? appSizes.height * 0.06 : appSizes.width * 0.06,
          height: isPortrait ? appSizes.height * 0.06 : appSizes.width * 0.06,
          decoration: BoxDecoration(
              color: Colors.green.withAlpha(40),
              borderRadius: BorderRadius.circular(11)
          ),
          child: Icon(icon,size: isPortrait ? appSizes.height * 0.035 : appSizes.width * 0.035,color: Colors.green,),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,textScaler: TextScaler.linear(1),style: TextStyle(fontWeight: FontWeight.bold,fontSize: isPortrait ? appSizes.height * 0.018 : appSizes.width * 0.018),),
            Text(subTitle,textScaler: TextScaler.linear(1),style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.012 : appSizes.width * 0.012,color: Colors.grey),),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: appSizes.height * 0.01,
          children: [
            Text(trailingText,textScaler: TextScaler.linear(1.2),),
            Icon(Icons.arrow_forward_ios_outlined,size: appSizes.height * 0.016,)
          ],
        ),
      ),
    );
  }
}
