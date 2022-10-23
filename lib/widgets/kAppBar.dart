import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets/authwithgoogle.dart';

AppBar kAppBar(
  BuildContext context,
) {
  return AppBar(
    title: FirebaseAuth.instance.currentUser!.displayName != null
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
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.search,
            color: Colors.blueGrey,
          )),
      TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      content: TextButton(
                          onPressed: () {
                            signOut();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Confirm",
                            style: TextStyle(color: Colors.white54),
                          )),
                      backgroundColor: Colors.black54,
                      title: const Text(
                        "Sign out",
                        style: TextStyle(color: Colors.white54),
                      ),
                    ));
          },
          child: const Text(
            "Sign Out",
            style: TextStyle(color: Colors.blueGrey),
          ))
    ],
  );
}