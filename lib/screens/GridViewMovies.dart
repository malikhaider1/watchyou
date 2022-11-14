import 'package:flutter/material.dart';

import '../widgets/gridView.dart';

class GridViewMoreMovies extends StatefulWidget {
  const GridViewMoreMovies({Key? key, required this.collectionName})
      : super(key: key);
  final String collectionName;
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
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: KGridView(
          collectionName: widget.collectionName,
        ),
      ),
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
