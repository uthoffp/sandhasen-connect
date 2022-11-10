import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sandhasen_connect/resources/strings.dart';

class FirebaseNotification {
  static void sendNotification(String title, String body) {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': Strings.firebaseAuthKey
    };
    var request =
        http.Request('POST', Uri.parse(Strings.firebaseFcmUrl));
    request.body = json.encode({
      "to": "/topics/all",
      "notification": {
        "title": title,
        "body": body,
        "mutable_content": true,
      }
    });
    request.headers.addAll(headers);

    request.send();
  }
}
