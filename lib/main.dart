import 'package:flutter/material.dart';
import 'package:car_connect/app/app.dart';
import 'package:car_connect/core/helper/app_info_helper.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/storage/shared/shared_pref.dart';

//
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await PackageInfo.fromPlatform().then((value) {
    AppInfoHelper.packageInfo = value;
  });

  SharedPreferences shPref = await SharedPreferences.getInstance();
  AppSharedPreferences.init(shPref);
  runApp(
    const CarConnect(),
  );
}



