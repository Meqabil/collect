import 'package:collect/main.dart';
import 'package:flutter/material.dart';

List contexts = ['first_context','second_context','third_context','fourth_context','fifth_context',];
List<String> contextsContents = List.generate(5, (idx){
  return prefs!.getString("context_content_$idx") ?? '';
});


//Debt screen elements

List titles = [ "pay_way", "number_of_installments", "created_at", "next_pay_date",];
const List icons = [Icons.credit_card, Icons.list_alt, Icons.date_range, Icons.date_range_sharp];