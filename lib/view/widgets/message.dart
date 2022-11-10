import 'package:flutter/material.dart';

//static function to show a simple snackbar for info or error messages
class Message {
  static void show(BuildContext context, String text, {Color? bgColor}) {
    var snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(text),
      backgroundColor: bgColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
