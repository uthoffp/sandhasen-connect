import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sandhasen_connect/data/firebase/info_requests.dart';
import 'package:sandhasen_connect/data/firebase/notification.dart';

class HomeViewModel {
  static FutureBuilder<DocumentSnapshot> getNews(currentContent) {
    return InfoRequest.readNewsData("news", currentContent);
  }

  static FutureBuilder<DocumentSnapshot> getHelp(currentContent) {
    return InfoRequest.readNewsData("help", currentContent);
  }

  static FutureBuilder<DocumentSnapshot> getImpressum(currentContent) {
    return InfoRequest.readNewsData("impressum", currentContent);
  }

  static Future<Map<String, dynamic>?> getInfoString() {
    return InfoRequest.getInfo();
  }

  static saveNews(String text, bool notify) {
    InfoRequest.saveInfoData("news", text);
    if (notify) {
      FirebaseNotification.sendNotification(
          "Neuigkeiten", "Es gibt Neuigkeiten in der App.");
    }
  }

  static saveHelp(String text) {
    InfoRequest.saveInfoData("help", text);
  }

  static saveImpressum(String text) {
    InfoRequest.saveInfoData("impressum", text);
  }
}
