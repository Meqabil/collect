import 'package:collect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthInput extends StatelessWidget {
  const AuthInput({super.key,required this.hint,required this.title,required this.icon,this.controller,this.idx,this.validator,this.keyboardType,this.onlyNumbers,this.onChanged});
  final int? idx;
  final String hint;
  final String title;
  final IconData icon;
  final bool? onlyNumbers;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(height: 12,),
        Container(
          color: Colors.white,
          height: 50,
          child: TextFormField(
            inputFormatters: onlyNumbers == true ? [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')), // Allows only numbers and one decimal point
            ] : [],
            keyboardType: keyboardType,
            controller: controller,
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.grey.shade500),
              suffix: Icon(icon),
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1,color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2,color: AppColors.mainAppColor),
                  borderRadius: BorderRadius.circular(15)
              ),
            ),
          ),
        ),
      ],
    );
  }
}

