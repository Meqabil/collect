import 'package:flutter/material.dart';

class DebtFilterChip extends StatelessWidget {
  const DebtFilterChip({super.key,required this.title,required this.icon,required this.selected,this.onTap,required this.color});
  final String title;
  final IconData icon;
  final bool selected;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: selected ? color.withAlpha(40) : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
        border: BoxBorder.all(color: selected ? color : Colors.grey,width: selected ? 1 : 0.7),
        boxShadow: !selected ? [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 3,
            spreadRadius: 0,
            offset: const Offset(0, -3),
          ),
          BoxShadow(
            color: Colors.black.withAlpha(22),
            blurRadius: 1,
            spreadRadius: -2,
            offset: const Offset(0, 3),
          ),
        ] : []
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Icon(icon,color: color,size: 20,),
              SizedBox(width: 10,),
              Text(title,textScaler: TextScaler.linear(1.1),style: TextStyle(fontSize: 12,),),
            ],
          ),
        ),
      ),
    );
  }
}
