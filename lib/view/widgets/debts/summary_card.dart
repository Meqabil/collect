import 'package:collect/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key,required this.title,required this.value,required this.icon,required this.color});
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: appSizes.height * 0.01,vertical: appSizes.height * 0.01),
      decoration: BoxDecoration(
          border: Border.all(width: .8,color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(11),
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 35,
              spreadRadius: 0,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withAlpha(12),
              blurRadius: 15,
              spreadRadius: -2,
              offset: const Offset(0, 2),
            ),
          ]
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,textScaler: TextScaler.linear(1),style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.015 : appSizes.width * 0.015),),
              Text(value,textScaler: TextScaler.linear(1),style: TextStyle(color: color,fontSize: isPortrait ? appSizes.height * 0.019 : appSizes.width * 0.019 ,fontWeight: FontWeight.bold),),
            ],
          ),
          Spacer(),
          Container(
            width: appSizes.height * 0.055,
            height: appSizes.height * 0.055,
            decoration: BoxDecoration(
                color: color.withAlpha(35),
                borderRadius: BorderRadius.circular(90)
            ),
            child: Icon(icon,color: color,size: appSizes.height * 0.03,),
          )
        ],
      ),
    );
  }
}
