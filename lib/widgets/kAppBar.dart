import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchyou/screens/SearchScreen.dart';
import 'package:watchyou/widgets/kAlertDialouge.dart';

AppBar kAppBar(
  BuildContext context,
) {
  return AppBar(
    title: FirebaseAuth.instance.currentUser!.displayName != ''
        ? Text(
            "${FirebaseAuth.instance.currentUser!.displayName}",
            style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 14,
                overflow: TextOverflow.ellipsis),
          )
        : Image.asset(
            'images/watchyouinnerlogo.png',
            color: Colors.blueGrey,
            width: 80,
            height: 80,
          ),
    backgroundColor: Colors.transparent,
    actions: [
      IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const SearchMovie()));
          },
          icon: const Icon(
            CupertinoIcons.search,
            color: Colors.blueGrey,
          )),
      TextButton(
          onPressed: () {
            kAlertDialogue(context);
          },
          child: const Text(
            "Sign Out",
            style: TextStyle(color: Colors.blueGrey),
          )),
    ],
  );
}
