import 'package:collect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({super.key,required this.size,required this.icon,required this.title,required this.selected,this.onTap});
  final double size;
  final String title;
  final IconData icon;
  final bool selected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size * 1.1,
        height: size,
        decoration: BoxDecoration(
          color: selected ? AppColors.mainAppColor.withAlpha(44) : Colors.grey.withAlpha(44),
          border: Border.all(
            width: !selected ? .7 : 1.4,
            color: selected ? AppColors.mainAppColor : Colors.grey
          ),
          borderRadius: BorderRadius.circular(7)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon,color: selected ? AppColors.mainAppColor : Colors.grey,size: size * .37,),
            Text(title,style: TextStyle(fontSize: 11,color: selected ? AppColors.mainAppColor : Colors.grey),)
          ],
        ),
      ),
    );
  }
}
