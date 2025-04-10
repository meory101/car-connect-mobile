import 'package:package_info_plus/package_info_plus.dart';
abstract class AppInfoHelper {
  static PackageInfo? packageInfo;


  static String getAppVersion() {
    return packageInfo?.version ?? "";
  }
}
