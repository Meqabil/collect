import 'package:collect/core/middleware/auth_middleware.dart';
import 'package:collect/core/middleware/onboarding_middleware.dart';
import 'package:collect/core/routes/app_routes.dart';
import 'package:collect/view/errors/no_internet_screen.dart';
import 'package:collect/view/screens/auth/auth_screen.dart';
import 'package:collect/view/screens/home/home_screen.dart';
import 'package:collect/view/screens/onboarding/on_boarding_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static List<GetPage<dynamic?>> pages = [
    GetPage(name: AppRoutes.onBoarding,page: () => OnBoardingScreen(),middlewares: [OnboardingMiddleware()]),
    GetPage(name: AppRoutes.auth,page: () => AuthScreen(),middlewares: [AuthMiddleware()]),
    GetPage(name: AppRoutes.home,page: () => HomeScreen()),
    GetPage(name: AppRoutes.noInternetConnection, page: () => NoInternetScreen()),
  ];
}

