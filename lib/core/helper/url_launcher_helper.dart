import 'package:url_launcher/url_launcher.dart';
abstract class UrlLauncherHelper {
  static Future<void> openUrl({required String pageName}) async {
    Uri uri = Uri.parse(pageName);
    await launchUrl(uri);
  }
}
