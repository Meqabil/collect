import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class TextArea extends StatelessWidget {
  const TextArea({super.key,required this.text,this.value,required this.controller});
  final TextEditingController controller;
  final String text;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        minLines: 3,
        maxLines: 3,
        initialValue: value,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey.shade500),
          hintText: text,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1,color: Colors.grey),
              borderRadius: BorderRadius.circular(15)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2,color: AppColors.mainAppColor),
              borderRadius: BorderRadius.circular(15)
          ),
        )
    );
  }
}
