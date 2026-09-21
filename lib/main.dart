
import 'package:collect/controller/localization/localization_controller.dart';
import 'package:collect/controller/theme/theme_controller.dart';
import 'package:collect/core/localization/app_translation.dart';
import 'package:collect/core/routes/app_pages.dart';
import 'package:collect/core/routes/app_routes.dart';
import 'package:collect/core/theme/dark_theme.dart';
import 'package:collect/core/theme/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/bindings.dart';
import 'core/security/encryption_service.dart';

extension ContextExtension on BuildContext{
  Size get size => MediaQuery.of(this).size;
}

SharedPreferences? prefs;
CipherService cipher = CipherService();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
  // runApp(
  //   DevicePreview(
  //     backgroundColor: Colors.lightGreen,
  //     enabled: true,
  //     tools: [...DevicePreview.defaultTools,CustomPlugin()],
  //     builder: (context) => MyApp(),
  //   )
  // );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    Get.put(LocalizationControllerImpl());
    return GetBuilder<LocalizationControllerImpl>(
      builder: (context) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: AppPages.pages,
          translations: AppTranslation(),
          locale: Locale(prefs?.getString('lang') ?? 'ar'),
          //home: FirebaseAuth.instance.currentUser == null ? AuthScreen() : HomeScreen(),
          initialBinding: InitialBindings(),
          initialRoute: AppRoutes.onBoarding,
          //home: AuthScreen(),
          theme: LightTheme.theme,
          darkTheme: DarkTheme.theme,
          themeMode: Get.put(ThemeControllerImpl()).isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        );
      }
    );
  }
}