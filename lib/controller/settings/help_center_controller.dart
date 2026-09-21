import 'package:collect/core/constants/help/help_data.dart';
import 'package:collect/main.dart';
import 'package:get/get.dart';

abstract class HelpCenterController extends GetxController{
  void loadData();
  Future<void> filterData(String v);
}

class HelpCenterControllerImpl extends HelpCenterController {
  List helpData = helpCenterData;
  List filteredData = [];

  loadData(){
    if(prefs!.getString('lang') == 'ar'){
      helpData = helpCenterDataArabic;
      filteredData = helpCenterDataArabic;
    }else{
      filteredData = helpCenterData;
    }
    update();
  }

  @override
  Future<void> filterData(String v) async{
    final query = v.trim().toLowerCase();
    if (query.isEmpty) {
      filteredData = helpData;
    } else {
      filteredData = helpData.where((data) {
        final question = data['question']?.toLowerCase() ?? '';
        return question.contains(query);
      }).toList();
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    if(prefs!.getString('lang') == 'ar'){
      helpData = helpCenterDataArabic;
      filteredData = helpCenterDataArabic;
    }else{
      filteredData = helpData;
    }
  }

}