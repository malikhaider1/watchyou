import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/LoginPage.dart';

class kTopBar extends StatelessWidget {
  const kTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 80,
            width: 120,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/watchyouinnerlogo.png'),
                  fit: BoxFit.fitWidth),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}