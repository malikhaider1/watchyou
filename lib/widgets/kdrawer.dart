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
            titleDrawerTile: "Action Movies",
          ),
          DrawerTile(
            movieType: 'anime',
            titleDrawerTile: "Anime Movies",
          ),
          DrawerTile(
            movieType: 'trending',
            titleDrawerTile: "Trending Movies",
          ),
          DrawerTile(
            movieType: 'comedies',
            titleDrawerTile: "comedies Movies",
          ),
          DrawerTile(
            movieType: 'familywatch',
            titleDrawerTile: "Family Watch Movies",
          ),
          DrawerTile(
            movieType: 'newrelease',
            titleDrawerTile: "newrelease Movies",
          ),
          DrawerTile(
            movieType: 'scifi',
            titleDrawerTile: "SciFi Movies",
          ),
          DrawerTile(
            movieType: 'horror',
            titleDrawerTile: "Horror Movies",
          ),
          DrawerTile(
            movieType: 'suspensefull',
            titleDrawerTile: "Suspensefull Movies",
          ),
          DrawerTile(
            movieType: 'romance',
            titleDrawerTile: "Romance Movies",
          ),
          DrawerTile(
            movieType: 'reallife',
            titleDrawerTile: "Reallife Movies",
          ),
          DrawerTile(
            movieType: 'addtodiary',
            titleDrawerTile: "Add to Diary Movies",
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
    required this.titleDrawerTile,
  }) : super(key: key);
  final String movieType;
  final String titleDrawerTile;
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
                        titleMovies: titleDrawerTile,
                        movieType: movieType,
                      )));
        },
        title: Text(
          titleDrawerTile,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
