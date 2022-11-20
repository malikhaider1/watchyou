import 'package:flutter/material.dart';
import 'package:watchyou/screens/updateInformation.dart';

import '../firebaseCrud/firebaseCreateReadUpdateDelete.dart';
import '../firebaseCrud/firebaseJasonData.dart';
import '../widgets/showsnackbar.dart';

class Movies extends StatefulWidget {
  const Movies({Key? key, required this.movieType, required this.titleMovies})
      : super(key: key);
  final String? movieType;
  final String titleMovies;
  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  @override
  Widget build(BuildContext context) {
    return MoviesDisplayAdmin(
      titleDisplay: widget.titleMovies,
      movieTypeRead: "${widget.movieType}",
    );
  }
}

class MoviesDisplayAdmin extends StatelessWidget {
  const MoviesDisplayAdmin({
    Key? key,
    required this.movieTypeRead,
    required this.titleDisplay,
  }) : super(key: key);
  final String movieTypeRead;
  final String titleDisplay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(titleDisplay),
      ),
      body: StreamBuilder<List<FirebaseJasonData>>(
          stream: FirebaseCreateReadUpdateDelete.read(movieTypeRead),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              showSnackBar("Something Went Wrong", context);
            }
            if (snapshot.hasData) {
              final userData = snapshot.data;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: userData!.length,
                itemBuilder: (BuildContext context, int index) {
                  final singleActionMovieData = userData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 2,
                              offset: Offset.fromDirection(-2, 1),
                            ),
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 2,
                              offset: Offset.fromDirection(-2, -1),
                            )
                          ],
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "${singleActionMovieData.imageUrl}",
                                        ),
                                        fit: BoxFit.contain,
                                      )),
                                  width: 68,
                                  height: 100,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("${singleActionMovieData.movieName}"),
                                  Text(
                                    "${singleActionMovieData.genre?.substring(0, 10)}",
                                  ),
                                  Text("${singleActionMovieData.duration}"),
                                  Text("${singleActionMovieData.maturity}"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        UpdateInformation(
                                                          collectionNameToUpdate:
                                                              movieTypeRead,
                                                          jasonData:
                                                              FirebaseJasonData(
                                                            id: singleActionMovieData
                                                                .id,
                                                            imdbRating:
                                                                singleActionMovieData
                                                                    .imdbRating,
                                                            imageUrl:
                                                                singleActionMovieData
                                                                    .imageUrl,
                                                            videoUrl:
                                                                singleActionMovieData
                                                                    .videoUrl,
                                                            movieName:
                                                                singleActionMovieData
                                                                    .movieName,
                                                            maturity:
                                                                singleActionMovieData
                                                                    .maturity,
                                                            genre:
                                                                singleActionMovieData
                                                                    .genre,
                                                            description:
                                                                singleActionMovieData
                                                                    .genre,
                                                            duration:
                                                                singleActionMovieData
                                                                    .duration,
                                                            movieUrl:
                                                                singleActionMovieData
                                                                    .movieUrl,
                                                          ),
                                                        )));
                                      },
                                      icon: const Icon(Icons.edit_note)),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: Text("Delete "),
                                                  content:
                                                      Text("Confirm to delete"),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        FirebaseCreateReadUpdateDelete
                                                            .delete(
                                                                singleActionMovieData,
                                                                context,
                                                                movieTypeRead);
                                                      },
                                                      child: Text("Confirm"),
                                                    )
                                                  ],
                                                ));
                                      },
                                      icon: const Icon(
                                          Icons.delete_outline_rounded)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
