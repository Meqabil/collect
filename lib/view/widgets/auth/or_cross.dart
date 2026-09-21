import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrCross extends StatelessWidget {
  const OrCross({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      children: [
        Expanded(
          child: Divider(),
        ),
        Text(" ${'or_cross'.tr} "),
        Expanded(

          child: Divider(),
        ),
      ],
    );
  }
}
