import 'package:get/get_utils/src/extensions/internacionalization.dart';

List months = ["january","february","march","april","may","june","july","august","september","october","november","december"];
String monthDateFormat(DateTime date){
  return "${date.day} ${months[date.month - 1].toString().tr} ${date.year}";
}