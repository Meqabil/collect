import 'package:flutter/material.dart';

class DebtOptionsInput extends StatelessWidget {
  const DebtOptionsInput({super.key,required this.hint,required this.label,required this.required});
  final String label;
  final String hint;
  final bool required;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 7,
      children: [
        Text("Debt type",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
        Container(
          height: 40,
          padding: EdgeInsets.symmetric(vertical: 2,horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1,color: Colors.grey)
          ),
          child: DropdownButton(
            underline: Container(),
            isExpanded: true,
            style: TextStyle(fontSize: 14,color: Colors.black),
            value: 'v',
            items: [
              DropdownMenuItem(
                value: 'v',
                child: Text("Personal",),
              ),
              DropdownMenuItem(
                child: Text("Business"),
              ),
              DropdownMenuItem(
                child: Text("Other"),
              ),
            ],

            onChanged: (v) {

            },
          ),
        ),
      ],
    );
  }
}
