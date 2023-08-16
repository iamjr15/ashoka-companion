
import 'package:url_launcher/url_launcher.dart';

launchURL({required String Url}) async {
  var url = Url;
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

launchURLAndroid({required String Url}) async {
  var url = Url;
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}