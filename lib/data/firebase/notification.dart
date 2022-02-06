import 'dart:convert';
import 'package:http/http.dart' as http;

class FirebaseNotification {
  static void sendNotification(String title, String body) {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAHgXahqE:APA91bHSBvJ0xxihy1fe0Wfv56Ffax1gEkobV4PAO_XPct7rHeCapplm1yoBHXii2Rg-3UrlTX1lFptrJLcArk9Ddl42VIwWsDV2l8aWIlUfrnTQAcMkFbJKnCe_4tOD4Ra3PEPzYsNp'
    };
    var request =
        http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
    request.body = json.encode({
      "to": "/topics/all",
      "notification": {
        "title": title,
        "body": body,
        "mutable_content": true,
        "sound": "Tri-tone"
      }
    });
    request.headers.addAll(headers);

    request.send();
  }
}
