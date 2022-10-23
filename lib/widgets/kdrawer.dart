import 'package:flutter/material.dart';
import 'package:watchyou/screens/LoginPage.dart';

import '../collectionwithview/actionmovies.dart';

class KDrawer extends StatelessWidget {
  const KDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        children: [
          Card(
            elevation: 2,
            color: Colors.blueGrey,
            child: ListTile(
              hoverColor: Colors.blueGrey,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ActionMovies()));
              },
              title: const Text(
                'ActionMovies',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}