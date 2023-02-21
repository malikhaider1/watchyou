import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'DetailInfoScreen.dart';

class GridViewMoreMovies extends StatefulWidget {
  const GridViewMoreMovies({
    Key? key,
    required this.list,
  }) : super(key: key);

  // final String collectionName;
  final List list;

  @override
  State<GridViewMoreMovies> createState() => _GridViewMoreMoviesState();
}

class _GridViewMoreMoviesState extends State<GridViewMoreMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_sharp,
              size: 15,
            ),
          ),
          toolbarHeight: 35,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            "Choose Wisely",
            style: TextStyle(fontSize: 15),
          ),
        ),
        backgroundColor: Colors.black54,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: widget.list.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              final dataAccessor = widget.list[index];
              return GestureDetector(
                  onTap: () {},
                  child: Stack(children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DetailInfoScreen(
                                      userData: dataAccessor,
                                    )));
                      },
                      child: Center(
                        child: Container(
                          height: 120,
                          width: 90,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                color: Colors.blueGrey.withOpacity(0.2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: NetworkImage(
                                  '${dataAccessor.imageUrl}',
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 3,
                    //   left: 14,
                    //   child: Badge(
                    //     toAnimate: true,
                    //     shape: BadgeShape.square,
                    //     badgeColor: Colors.blueGrey.withOpacity(0.1),
                    //     borderRadius: BorderRadius.circular(15),
                    //     badgeContent: Text('⭐ ${dataAccessor.imdbRating}',
                    //         style: TextStyle(
                    //             color: Colors.white.withOpacity(0.7))),
                    //   ),
                    // )
                  ]));
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
          ),
        )

        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 10),
        //   child: KGridView(
        //     collectionName: widget.collectionName,
        //   ),
        // ),
        // body: GridView.builder(
        //   gridDelegate:
        //       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        //   itemBuilder: (BuildContext context, int index) {
        //     return Container();
        //   },
        // ),
        );
  }
}
