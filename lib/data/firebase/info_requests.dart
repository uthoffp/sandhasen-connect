import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/widgets/message.dart';

class InfoRequest {
  static FutureBuilder<DocumentSnapshot> readNewsData(
      String type, Widget currentContent) {
    CollectionReference info = FirebaseFirestore.instance.collection(Strings.info);
    return FutureBuilder<DocumentSnapshot>(
      future: info.doc(Strings.infoDocId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError || (snapshot.hasData && !snapshot.data!.exists)) {
          Message.show(context, Strings.errorRequest);
          return currentContent;
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return SingleChildScrollView(
            child: Padding(
              child: Html(data: data[type]),
              padding: const EdgeInsets.all(8),
            ),
          );
        }
        return const LinearProgressIndicator();
      },
    );
  }

  static Future<Map<String, dynamic>?> getInfo() async {
    var snapshot = await FirebaseFirestore.instance
        .collection(Strings.info)
        .doc(Strings.infoDocId)
        .get();
    return snapshot.data();
  }

  static Future<void> saveInfoData(String type, String text) async {
    CollectionReference info = FirebaseFirestore.instance.collection(Strings.info);
    info.doc(Strings.infoDocId).update({type: text});
  }
}
