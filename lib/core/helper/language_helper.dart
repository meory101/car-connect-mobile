import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_connect/core/storage/shared/shared_pref.dart';
abstract class LanguageHelper {
  static bool checkIfLTR({required BuildContext context}) {
    return (AppSharedPreferences.getLanguage() == 'en' ||
            AppSharedPreferences.getLanguage() == 'fr')
        ? true
        : false;
    // return Directionality.of(context)
    // ==
    // TextDirection
    // .
    // ltr;
  }

  static bool isEnglishData(
      {required BuildContext context, required String data}) {
    if (data.isEmpty) return checkIfLTR(context: context);

    data = data.replaceAll(RegExp(r'[^\w\u0600-\u06FF\s]'), '');

    bool isOk = data.trim().startsWith(RegExp(r'[A-Za-z]'), 0);

    return isOk;
  }
}
