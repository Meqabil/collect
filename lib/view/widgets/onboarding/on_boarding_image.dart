import 'package:collect/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class OnBoardingImage extends StatelessWidget {
  const OnBoardingImage({super.key,required this.image,this.hasShadow});
  final String image;
  final bool? hasShadow;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    return Container(
      width: appSizes.width / 1.2,
      height: !isPortrait ? isNotPhone ? appSizes.height / 1.7 : appSizes.height / 1.2 : appSizes.width / 1.4,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(hasShadow == true ? 12 :  0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          hasShadow == true ? BoxShadow(color: Colors.grey,blurStyle: BlurStyle.outer,spreadRadius: 5,blurRadius: 3) : BoxShadow(),
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset(image,fit: BoxFit.cover,),
      ),
    );
  }
}
