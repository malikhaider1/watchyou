import 'package:flutter/material.dart';

import '../assets/authwithgoogle.dart';

kAlertDialogue(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            content: const Text(
              "Are you sure, Do You want to Continue?",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade200),
                  onPressed: () {
                    signOut();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.white),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "No",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
            backgroundColor: Colors.white,
            title: const Text(
              "Sign Out",
              style: TextStyle(color: Colors.black),
            ),
          ));
}
