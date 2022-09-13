import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/pages/home/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.subscribeToTopic('all');
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyD_K1BqtESTlhNT2yHxAmvdEV7BFKrC3qY",
        databaseURL: "https://sandhasen-connect.firebaseio.com",
        appId: "1:128947226273:web:f0ed9b00e305f638de92e0",
        messagingSenderId: "G-NXNRT1D3Y5",
        projectId: "sandhasen-connect",
        authDomain: "sandhasen-connect.firebaseapp.com",
        storageBucket: "sandhasen-connect.appspot.com",
      ),
    );
  }
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
        textTheme: const TextTheme(
            bodyText1: TextStyle(fontSize: 18.0),
            bodyText2: TextStyle(fontSize: 16.0),
            button: TextStyle(fontSize: 16.0),
        ),
      ),
      home: const MainPage(title: Strings.appName),
    );
  }
}
