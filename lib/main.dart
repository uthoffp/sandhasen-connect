import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/pages/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  firebaseMessaging.subscribeToTopic('all');

  runApp(const SandhasenConnect());
}

class SandhasenConnect extends StatelessWidget {
  const SandhasenConnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(title: Strings.appName),
    );
  }
}
