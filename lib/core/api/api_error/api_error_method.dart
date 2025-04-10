import 'package:flutter/cupertino.dart';
import 'package:car_connect/core/storage/shared/shared_pref.dart';
import 'package:car_connect/router/router.dart';

abstract class ApiErrorMethod {
  static void invalidSessionToken({required BuildContext context}) {
    AppSharedPreferences.clear();
  }

  static void noInternetConnection({required BuildContext context}) {
  }

  static void serverError({required BuildContext context}) {
    // Navigator.of(context).pushReplacementNamed(RouteNamedScreens.noInternet);
  }
}
