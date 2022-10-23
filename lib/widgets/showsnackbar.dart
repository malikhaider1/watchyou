import 'package:flutter/material.dart';

import '../screens/LoginPage.dart';

showSnackBar(String message, context) {
  final snackBar = SnackBar(
    backgroundColor: primaryColor,
    content: Text(
      message,
      style: TextStyle(color: Colors.black),
    ),
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}