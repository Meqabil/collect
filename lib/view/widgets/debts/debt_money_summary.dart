import 'package:collect/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DebtMoneySummary extends StatelessWidget {
  const DebtMoneySummary({
    super.key,
    required this.debtTitle,
    required this.debtValue,
    required this.payedTitle,
    required this.payedValue,
    required this.restTitle,
    required this.restValue
  });
  final String debtTitle;
  final String debtValue;
  final String payedTitle;
  final String payedValue;
  final String restTitle;
  final String restValue;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      width: isNotPhone ? appSizes.width / 2 - 10 : appSizes.width,
      margin: EdgeInsets.symmetric(vertical: appSizes.height * 0.01,horizontal: appSizes.height * 0.002),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
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
      child: Container(
        padding: EdgeInsets.all(appSizes.height * 0.01),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(debtTitle,style: TextStyle(color: Colors.grey.shade600,fontSize: isPortrait ? appSizes.height * 0.017 : appSizes.width * 0.017),),
                    Text(debtValue,style: TextStyle(color: Colors.blue,fontSize: isPortrait ? appSizes.height * 0.021 : appSizes.width * 0.021,fontWeight: FontWeight.bold),),
                    Text("l.e".tr,style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.016 : appSizes.width * 0.016),)
                  ],
                ),
                SizedBox(
                  width: appSizes.height * 0.05,
                  height: appSizes.height * 0.05,
                  child: VerticalDivider(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(payedTitle,style: TextStyle(color: Colors.grey.shade600,fontSize: isPortrait ? appSizes.height * 0.017 : appSizes.width * 0.017,),),
                    Text(payedValue,style: TextStyle(color: Colors.green,fontSize: isPortrait ? appSizes.height * 0.02 : appSizes.width * 0.02,fontWeight: FontWeight.bold),),
                    Text("l.e".tr,style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.016 : appSizes.width * 0.016),)
                  ],
                ),
                SizedBox(
                  width: appSizes.height * 0.05,
                  height: appSizes.height * 0.05,
                  child: VerticalDivider(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(restTitle,style: TextStyle(color: Colors.grey.shade600,fontSize: isPortrait ? appSizes.height * 0.017 : appSizes.width * 0.017),),
                    Text(restValue,style: TextStyle(color: Colors.red,fontSize: isPortrait ? appSizes.height * 0.020 : appSizes.width * 0.020,fontWeight: FontWeight.bold),),
                    Text("l.e".tr,style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.016 : appSizes.width * 0.016),)
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Text("payed".tr),
                Expanded(
                  child: Theme(
                    data: ThemeData(
                      sliderTheme: SliderThemeData(
                        thumbShape: SliderComponentShape.noThumb
                      )
                    ),
                    child: Slider(
                      value: int.parse(payedValue) / int.parse(debtValue) * 100,
                      activeColor: Colors.green,
                      max: 100,
                      onChanged: (v){},
                    ),
                  ),
                ),
                Text("${(int.parse(payedValue) / int.parse(debtValue) * 100).toStringAsFixed(0)}%"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
