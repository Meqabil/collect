import 'package:collect/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class DebtorActionButton extends StatelessWidget {
  const DebtorActionButton({super.key,this.onTap,required this.title,required this.icon,required this.color});
  final String title;
  final IconData icon;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Container(
              width:  isPortrait ? appSizes.height * 0.064 : appSizes.width * 0.06,
              height: isPortrait ? appSizes.height * 0.064 : appSizes.width * 0.06,
              decoration: BoxDecoration(
                  color: color.withAlpha(40),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Icon(icon,color: color,size: isPortrait ? appSizes.height * 0.03 : appSizes.width * 0.03,),
            ),
            Text(title,style: TextStyle(color: color),),
          ],
        ),
      ),
    );
  }
}
