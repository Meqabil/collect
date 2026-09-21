import 'package:collect/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../core/constants/assets/app_images.dart';



class DebtorBoard extends StatelessWidget {
  const DebtorBoard({super.key,required this.name,required this.phone,required this.address,required this.type,this.note,this.hasEditButton,this.onEditButtonPressed});
  final String name;
  final String phone;
  final String address;
  final String type;
  final String? note;
  final bool? hasEditButton;
  final void Function()? onEditButtonPressed;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    return Container(
      width: isNotPhone ? appSizes.width / 2 - 20 : appSizes.width,
      height: isPortrait ? note == null || note == '' || note == '' ? appSizes.height / 8 : appSizes.height / 5 : appSizes.height / 3,
      padding: EdgeInsets.symmetric(horizontal: 8),
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
                radius: appSizes.height * 0.045,
                backgroundImage: AssetImage(AppImages.avatar,),
              ),
              SizedBox(width: appSizes.height * 0.015,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.02 : appSizes.width * 0.02,fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: appSizes.height * 0.005,
                    children: [
                      Icon(Icons.call,size: appSizes.height * 0.014,color: Colors.grey,),
                      Text(phone,style: TextStyle(color: Colors.grey,fontSize: isPortrait ? appSizes.height * 0.0125 : appSizes.width * 0.0125),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: appSizes.height * 0.005,
                    children: [
                      Icon(Icons.location_on,size: 13,color: Colors.green,),
                      Text(address,style: TextStyle(color: Colors.grey,fontSize: 12),),
                    ],
                  ),
                  SizedBox(height: appSizes.height * 0.005,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: isPortrait ? appSizes.height * 0.0095 : appSizes.width * 0.015,vertical: appSizes.height * 0.006),
                    decoration: BoxDecoration(
                      color: type == "business" ? Colors.green.withAlpha(70) : Colors.deepPurple.withAlpha(70) ,
                      borderRadius: BorderRadius.circular(7)
                    ),
                    child: Text(type.tr,style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.01 : appSizes.width * 0.01,color: type == "business" ? Colors.green : Colors.deepPurple),),
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
          note == null || note == '' ? Container() : Spacer(),
          note == null || note == '' ? Container() : Text("${note}"),
          note == null || note == '' ? Container() : SizedBox(height: appSizes.height * 0.012,),
        ],
      ),
    );
  }
}
