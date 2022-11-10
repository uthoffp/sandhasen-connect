import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/firebase/info_requests.dart';
import 'package:sandhasen_connect/data/firebase/notification.dart';
import 'package:sandhasen_connect/resources/strings.dart';

class HomeViewModel {
  static FutureBuilder<DocumentSnapshot> getNews(currentContent) {
    return InfoRequest.readNewsData(Strings.news, currentContent);
  }

  static FutureBuilder<DocumentSnapshot> getHelp(currentContent) {
    return InfoRequest.readNewsData(Strings.help, currentContent);
  }

  static FutureBuilder<DocumentSnapshot> getImpressum(currentContent) {
    return InfoRequest.readNewsData(Strings.impressum, currentContent);
  }

  static Future<Map<String, dynamic>?> getInfoString() {
    return InfoRequest.getInfo();
  }

  static saveNews(String text, bool notify) {
    InfoRequest.saveInfoData(Strings.news, text);
    if (notify) {
      FirebaseNotification.sendNotification(
          Strings.notificationHeaderNews, Strings.notificationBodyNews);
    }
  }

  static saveHelp(String text) {
    InfoRequest.saveInfoData(Strings.help, text);
  }

  static saveImpressum(String text) {
    InfoRequest.saveInfoData(Strings.impressum, text);
  }
}
