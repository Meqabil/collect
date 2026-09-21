import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';

class DebtorInput extends StatelessWidget {
  const DebtorInput({super.key,required this.hint,required this.label,this.value,required this.required,this.controller,this.validator,this.numbersOnly});
  final String label;
  final String hint;
  final String? value;
  final bool required;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? numbersOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 9,
      children: [
        Row(
          children: [
            Text(label,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
            required ? Text(" *",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.red),) : Container(),
          ],
        ),
        TextFormField(
          controller: controller,
          initialValue: value,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: numbersOnly == true ? TextInputType.numberWithOptions(): TextInputType.text,
          inputFormatters: numbersOnly == true ? [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ] : [],
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
            constraints: BoxConstraints(
              maxHeight: 45,
              minHeight: 40,
            ),
            errorStyle: TextStyle(fontSize: 8),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: .8,
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(8)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1.2,
                    color: AppColors.mainAppColor
                ),
                borderRadius: BorderRadius.circular(8)
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.2,
                color: Colors.red
              ),
              borderRadius: BorderRadius.circular(8)
            ),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1.2,
                    color: Colors.red
                ),
                borderRadius: BorderRadius.circular(8)
            ),

          ),
        )
      ],
    );
  }
}
