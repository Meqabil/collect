import 'dart:ui';
import 'package:get/get.dart';
import '../../main.dart';

abstract class LocalizationController extends GetxController{
  void changeLanguage(String lang,String langName);
}

class LocalizationControllerImpl extends LocalizationController{

  Locale lang = Locale("en");
  String langCode = 'en';
  String langName = 'english';
  @override
  void changeLanguage(String languageCode,String languageName) {

    langCode = languageCode;
    langName = languageName;
    lang = Locale(languageCode);
    prefs!.setString('lang', languageCode);
    Get.updateLocale(lang);
    update();
  }
  @override
  void onInit() {
    super.onInit();
    langCode = prefs?.getString("lang") ?? 'ar';
  }
}