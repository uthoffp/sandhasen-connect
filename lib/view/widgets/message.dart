import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//static function to show simple a snackbar for info or error messages
class Message {
  static void show(BuildContext context, String text) {
    var snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(text),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
