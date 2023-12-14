import 'package:url_launcher/url_launcher.dart';

class GenFunc {
  static Future<void> launchUrl1(String url) async {
    Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url0');
    }
  }
}
