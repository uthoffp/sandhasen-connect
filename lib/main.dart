import 'package:flutter/material.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/pages/main_page.dart';

void main() {
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
