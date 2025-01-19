import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message,
      Color backgroundColor, Color textColor) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
