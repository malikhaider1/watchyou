import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchyou/firebaseCrud/firebaseJasonData.dart';
import 'package:watchyou/screens/DetailInfoScreen.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({Key? key}) : super(key: key);

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

CollectionReference _reference =
    FirebaseFirestore.instance.collection('movies');

class _SearchMovieState extends State<SearchMovie> {
  String query = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          SizedBox(
            height: 50,
            width: 320,
            child: CupertinoSearchTextField(
              style: const TextStyle(color: Colors.blueGrey),
              onSubmitted: (v) {
                query = v;
              },
              onChanged: (search) {
                setState(() {
                  query = search;
                });
              },
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _reference.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          } else {
            if (snapshot.data!.docs
                .where((element) => element['moviename']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
                .isEmpty) {
              return const Center(
                child: Text(
                  "Result not Found",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              return searchListWidget(snapshot);
            }
          }
        },
      ),
    );
  }

  ListView searchListWidget(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView(
      children: [
        ...snapshot.data!.docs
            .where((QueryDocumentSnapshot<Object?> element) =>
                element['moviename']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .map((QueryDocumentSnapshot<Object?> data) {
          final movie = FirebaseJasonData.fromJason(data);

          return Center(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => DetailInfoScreen(
                              userData: movie,
                            )));
              },
              trailing: Text(
                movie.duration!,
                style: const TextStyle(color: Colors.white),
              ),
              title: Text(
                movie.movieName!,
                style: const TextStyle(color: Colors.white),
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(movie.imageUrl!),
              ),
              subtitle: Text(movie.genre!,
                  style: const TextStyle(color: Colors.white)),
            ),
          );
        })
      ],
    );
  }
}
