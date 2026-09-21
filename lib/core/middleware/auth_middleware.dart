
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware{

  @override
  RouteSettings? redirect(String? route){
    print(prefs!.getString("logged_in"));
    if(prefs!.getString("logged_in") == 'yes'){

      return RouteSettings(name: AppRoutes.home);
    }
    return null;
  }
}