import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/pages/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  firebaseMessaging.subscribeToTopic('all');
  await Firebase.initializeApp(
    // Replace with actual values
    options: const FirebaseOptions(
        apiKey: "AIzaSyD_K1BqtESTlhNT2yHxAmvdEV7BFKrC3qY",
        authDomain: "sandhasen-connect.firebaseapp.com",
        projectId: "sandhasen-connect",
        storageBucket: "sandhasen-connect.appspot.com",
        messagingSenderId: "128947226273",
        appId: "1:128947226273:web:f0ed9b00e305f638de92e0",
        measurementId: "G-NXNRT1D3Y5"
    ),
  );
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
