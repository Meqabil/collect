
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/theme/app_colors.dart';
import 'package:collect/view/widgets/onboarding/on_boarding_image.dart';
import 'package:flutter/material.dart';
class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({super.key,required this.image,required this.title,required this.description,this.hasShadow});
  final String image;
  final String title;
  final String description;
  final bool? hasShadow;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    return Container(
      padding: EdgeInsets.all(12),
      width: appSizes.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: appSizes.height * 0.0156,),
          OnBoardingImage(image: image,hasShadow: hasShadow,),
          SizedBox(height: appSizes.height * 0.025,),
          Text(title,style: TextStyle(fontSize: !isNotPhone && isPortrait ? appSizes.height * 0.035 : appSizes.width * 0.035,fontWeight: FontWeight.bold,color: AppColors.mainAppColor),),
          SizedBox(height: appSizes.height * 0.025,),
          Text(description,style: TextStyle(fontSize: !isNotPhone && isPortrait ? appSizes.height * 0.02 : appSizes.width * 0.02,color: Colors.grey.shade600),textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
