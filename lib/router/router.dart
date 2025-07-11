import 'package:car_connect/feature/auth/screen/personal_info.dart';
import 'package:car_connect/feature/auth/screen/verification_code_screen.dart';
import 'package:car_connect/feature/board/screen/add_car_screen.dart';
import 'package:car_connect/feature/board/screen/car_orders_screen.dart';
import 'package:car_connect/feature/board/screen/cutomer_orders.dart';
import 'package:car_connect/feature/board/screen/my_cars_screen.dart';
import 'package:car_connect/feature/home/screen/car_details_screen.dart';
import 'package:car_connect/feature/home/screen/home_screen.dart';
import 'package:car_connect/feature/home/screen/rent_car_screen.dart';
import 'package:car_connect/feature/main/screen/main_bottom_app_bar.dart';
import 'package:car_connect/feature/profile/presentation/profile_screen.dart';
import 'package:car_connect/feature/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../core/navigation/fade_builder_route.dart';
import '../feature/auth/screen/login_screen.dart';
import '../feature/board/screen/business_reservations_screen.dart';
import '../feature/board/screen/favorites_screen.dart';
import '../feature/board/screen/reservations_screen.dart';
import '../feature/home/screen/cart_screen.dart';

abstract class RouteNamedScreens {
  static String init = splash;
  static const String splash = "/splash";
  static const String main = "/main";
  static const String profile = "/profile";
  static const String myOrders = "/myOrders";
  static const String carDetails = "/car-details";
  static const String login = "/login";
  static const String personalInfo = "/personal-info";
  static const String home = "/home";
  static const String verification = "/verification";
  static const String addCar = "/add-car";
  static const String myCars = "/myCars";
  static const String carOrders = "/car-orders";
  static const String myFavorites = "/my-favorites";
  static const String cart = "/my-cart";
  static const String rentCar = "/rent";
  static const String reservations = '/reservations';
  static const String businessReservations = '/business-reservations';
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

      case RouteNamedScreens.myFavorites:
        return FadeBuilderRoute(
          page: const FavoritesScreen(),
        );

      case RouteNamedScreens.rentCar:
        argument as CartArgs;
        return FadeBuilderRoute(
          page: RentCarScreen(
            args: argument,
          ),
        );
      case RouteNamedScreens.cart:
        argument as CartArgs;
        return FadeBuilderRoute(
          page: CartScreen(
            args: argument,
          ),
        );

      case RouteNamedScreens.login:
        return FadeBuilderRoute(
          page: const LoginScreen(),
        );
      case RouteNamedScreens.verification:
        argument as VerificationArgs;
        return FadeBuilderRoute(
          page: VerificationCodeScreen(
            args: argument,
          ),
        );

      case RouteNamedScreens.addCar:
        return FadeBuilderRoute(
          page: const AddCarScreen(),
        );

      case RouteNamedScreens.myOrders:
        return FadeBuilderRoute(
          page: const CustomerOrdersScreen(),
        );
      case RouteNamedScreens.myCars:
        return FadeBuilderRoute(
          page: const MyCarsScreen(),
        );
      case RouteNamedScreens.carDetails:
        argument as CarDetailsArgs;
        return FadeBuilderRoute(
          page: CarDetailsScreen(
            args: argument,
          ),
        );
      case RouteNamedScreens.main:
        return FadeBuilderRoute(
          page: const MainAppBottomAppBar(),
        );
      case RouteNamedScreens.profile:
        return FadeBuilderRoute(
          page: const ProfileScreen(),
        );
      case RouteNamedScreens.carOrders:
        return FadeBuilderRoute(
          page: const CarOrdersScreen(),
        );
      case RouteNamedScreens.home:
        return FadeBuilderRoute(
          page: const HomeScreen(),
        );
      case RouteNamedScreens.personalInfo:
        return FadeBuilderRoute(
          page: const PersonalInfo(),
        );
      case RouteNamedScreens.reservations:
        return MaterialPageRoute(
          builder: (context) => const ReservationsScreen(),
        );
      case RouteNamedScreens.businessReservations:
        return MaterialPageRoute(
          builder: (context) => const BusinessReservationsScreen(),
        );
    }
    return FadeBuilderRoute(page: const SplashScreen());
  }
}

abstract class CurrentRoute {
  static String? currentRouteName;

  CurrentRoute({required String currentRouteName});
}
