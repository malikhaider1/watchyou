import 'package:flutter/material.dart';

import '../collectionwithview/Movies.dart';

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
        children: const [
          DrawerTile(
            movieType: 'action',
            title: "Action Movies",
          ),
          DrawerTile(
            movieType: 'anime',
            title: "Anime Movies",
          ),
          DrawerTile(
            movieType: 'trending',
            title: "Trending Movies",
          ),
          DrawerTile(
            movieType: 'comedies',
            title: "comedies Movies",
          ),
          DrawerTile(
            movieType: 'familywatch',
            title: "Family Watch Movies",
          ),
          DrawerTile(
            movieType: 'newrelease',
            title: "newrelease Movies",
          ),
          DrawerTile(
            movieType: 'scifi',
            title: "SciFi Movies",
          ),
          DrawerTile(
            movieType: 'horror',
            title: "Horror Movies",
          ),
          DrawerTile(
            movieType: 'suspensefull',
            title: "Suspensefull Movies",
          ),
          DrawerTile(
            movieType: 'romance',
            title: "Romance Movies",
          ),
          DrawerTile(
            movieType: 'reallife',
            title: "Reallife Movies",
          ),
          DrawerTile(
            movieType: 'addtodiary',
            title: "Add to Diary Movies",
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key? key,
    required this.movieType,
    required this.title,
  }) : super(key: key);
  final String movieType;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.blueGrey,
      child: ListTile(
        hoverColor: Colors.blueGrey,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Movies(
                        title: title,
                        movieType: movieType,
                      )));
        },
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
