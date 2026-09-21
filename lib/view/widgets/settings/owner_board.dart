import 'package:collect/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/assets/app_images.dart';

class OwnerBoard extends StatelessWidget {
  const OwnerBoard({super.key,required this.name,required this.email,this.image,this.hasEditButton,this.onEditButtonPressed});
  final String name;
  final String email;
  final String? image;
  final bool? hasEditButton;
  final void Function()? onEditButtonPressed;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      width: appSizes.width,
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: appSizes.height / 8,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: appSizes.height * 0.01,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: appSizes.height * 0.04,
                backgroundImage: image == null ? AssetImage(AppImages.avatar,) : NetworkImage(image!),
              ),
              SizedBox(width: appSizes.height * 0.015,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,textScaler: TextScaler.linear(1.2),style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.018 : appSizes.width * 0.018,fontWeight: FontWeight.bold,),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 5,
                    children: [
                      Icon(Icons.email,size: isPortrait ? appSizes.height * 0.015 : appSizes.width * 0.018,color: Colors.green,),
                      Text(email,textScaler: TextScaler.linear(1.1),style: TextStyle(color: Colors.grey,fontSize: isPortrait ? appSizes.height * 0.013 : appSizes.width * 0.013),),
                    ],
                  ),
                ],
              ),
              hasEditButton == true? Spacer() : Container(),
              hasEditButton == true ? IconButton(
                  onPressed: onEditButtonPressed,
                  icon: Icon(Icons.edit,color: Colors.green,)
              ) : Container()
            ]
          ),
        ],
      ),
    );
  }
}
