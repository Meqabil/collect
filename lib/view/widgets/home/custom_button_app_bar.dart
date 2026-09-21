
import 'package:collect/main.dart';
import 'package:flutter/material.dart';

class CustomButtonAppBar extends StatelessWidget {
  const CustomButtonAppBar({super.key,this.onTap,required this.text,required this.icon,required this.activeColor});
  final void Function()? onTap;
  final String text;
  final IconData icon;
  final Color activeColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        height: 60,
        child: Column(
          children: [
            Icon(icon,color: activeColor,),
            Text(text,textScaler: TextScaler.linear(1),style: TextStyle(color: activeColor,fontSize: (prefs!.getString('lang') == 'es' || prefs!.getString('lang') == 'de' || prefs!.getString('lang') == 'fr' || prefs!.getString('lang') == 'it') ? 9 : 14),),
          ],
        ),
      ),
    );
  }
}