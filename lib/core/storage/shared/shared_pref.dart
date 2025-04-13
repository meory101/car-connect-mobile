import 'package:shared_preferences/shared_preferences.dart';

import '../../resource/key_manger.dart';

abstract class AppSharedPreferences {
  static late SharedPreferences _sharedPreferences;

  static init(SharedPreferences sh) {
    _sharedPreferences = sh;
  }

  static clear() {
    _sharedPreferences.clear();
  }

  static void cashAuthType({required String authType}) {
    _sharedPreferences.setString(AppKeyManager.authType, authType);
  }

  static void cashUserId({required String userId}) {
    _sharedPreferences.setString(AppKeyManager.userId, userId);
  }

  static void cashUserNameEn({required String userName}) {
    _sharedPreferences.setString(AppKeyManager.userNameEn, userName);
  }

  static void cashDesc({required String desc}) {
    _sharedPreferences.setString("desc", desc);
  }

  static void cashLat({required String lat}) {
    _sharedPreferences.setString("lat", lat);
  }

  static void cashLong({required String long}) {
    _sharedPreferences.setString("long", long);
  }

  static void cashCommercialRegister({required String register}) {
    _sharedPreferences.setString("register", register);
  }

  static void cashIdImage({required String idImage}) {
    _sharedPreferences.setString("idImage", idImage);
  }

  static void cashUserNameAr({required String userName}) {
    _sharedPreferences.setString(AppKeyManager.userNameAr, userName);
  }

  static void cashToken({required String token}) {
    _sharedPreferences.setString(AppKeyManager.token, token);
  }

  static void cashLanguage({required String language}) {
    _sharedPreferences.setString(AppKeyManager.language, language);
  }

  static void cashUserEmail({required String userEmail}) {
    _sharedPreferences.setString(AppKeyManager.userEmail, userEmail);
  }

  static String getCashedValueByKey(String key) {
    return _sharedPreferences.getString(key) ?? "";
  }

  static void cashedValueByKey(String key, String value) async {
    _sharedPreferences.setString(key, value);
  }

  static String getLanguage() {
    return _sharedPreferences.getString(AppKeyManager.language) ??
        AppKeyManager.defaultLanguageCode;
  }

  static String getToken() {
    return _sharedPreferences.getString(AppKeyManager.token) ?? '';
  }

  static String getName() {
    return _sharedPreferences.getString(AppKeyManager.token) ?? '';
  }

  static String getUserId() {
    return _sharedPreferences.getString(AppKeyManager.userId) ?? '';
  }

  static String getUserEmail() {
    return _sharedPreferences.getString(AppKeyManager.userEmail) ?? ' ';
  }

  static String getAuthType() {
    return _sharedPreferences.getString(AppKeyManager.authType) ?? '';
  }

  static String getUserNameAr() {
    return _sharedPreferences.getString(AppKeyManager.userNameAr) ?? '';
  }

  static String getUserNameEn() {
    return _sharedPreferences.getString(AppKeyManager.userNameEn) ?? '';
  }


  static String getDesc() {
    return _sharedPreferences.getString("desc") ?? '';
  }
  static String getLat() {
    return _sharedPreferences.getString("lat") ?? '';
  }
  static String getLong() {
    return _sharedPreferences.getString("long") ?? '';
  }
  static String getCommercialRegister() {
    return _sharedPreferences.getString("register") ?? '';
  }
  static String getIdImage() {
    return _sharedPreferences.getString("idImage") ?? '';
  }
}
