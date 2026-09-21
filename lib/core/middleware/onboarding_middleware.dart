import 'package:collect/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';


class OnboardingMiddleware extends GetMiddleware{
  @override
  RouteSettings? redirect(String? route){
    if(prefs!.getString("onboarding") == 'yes'){
      return RouteSettings(name: AppRoutes.auth);
    }
    return null;
  }
}