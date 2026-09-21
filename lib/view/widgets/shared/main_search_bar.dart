import 'package:flutter/material.dart';

class MainSearchBar extends StatelessWidget {
  const MainSearchBar({super.key,required this.hint,this.onChanged});
  final String hint;
  final void Function(String)? onChanged;
@override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey,fontSize: 11),
        prefixIcon: Icon(Icons.search,color: Colors.grey,),
        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 0.8,color: Colors.grey)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1.4,color: Colors.green)
        ),
      ),
    );
  }
}
