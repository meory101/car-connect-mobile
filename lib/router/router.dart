import 'package:car_connect/feature/auth/screen/personal_info.dart';
import 'package:car_connect/feature/auth/screen/verification_code_screen.dart';
import 'package:car_connect/feature/home/screen/home_screen.dart';
import 'package:car_connect/feature/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../core/navigation/fade_builder_route.dart';
import '../feature/auth/screen/login_screen.dart';



abstract class RouteNamedScreens {
  static String init = splash;
  static const String splash = "/splash";
  static const String login = "/login";
  static const String personalInfo = "/personal-info";
  static const String home = "/home";
  static const String verification = "/verification";
}

abstract class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    // ignore: body_might_complete_normally_nullable

    final argument = settings.arguments;

    switch (settings.name) {
      case RouteNamedScreens.splash:
        return FadeBuilderRoute(
          page: const SplashScreen(),
        );
      case RouteNamedScreens.login:
        return FadeBuilderRoute(
          page: const LoginScreen(),
        );
      case RouteNamedScreens.verification:
        return FadeBuilderRoute(
          page: const VerificationCodeScreen(),
        );
      case RouteNamedScreens.home:
        return FadeBuilderRoute(
          page: const HomeScreen(),
        );
      case RouteNamedScreens.personalInfo:
        return FadeBuilderRoute(
          page: const PersonalInfo(),
        );
    }
    return FadeBuilderRoute(page: const SplashScreen());
  }
}

abstract class CurrentRoute {
  static String? currentRouteName;

  CurrentRoute({required String currentRouteName});
}
