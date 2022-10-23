import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseJasonData {
  FirebaseJasonData(
      {this.movieUrl,
      this.movieName,
      this.imdbRating,
      this.description,
      this.maturity,
      this.duration,
      this.videoUrl,
      this.imageUrl,
      this.genre,
      this.id});

  final String? id;
  final String? movieName;
  final String? imdbRating;
  final String? description;
  final String? maturity;
  final String? duration;
  final String? videoUrl;
  final String? imageUrl;
  final String? genre;
  final String? movieUrl;

  factory FirebaseJasonData.fromJason(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return FirebaseJasonData(
      movieUrl: snapshot['movieUrl'],
      movieName: snapshot['moviename'],
      imdbRating: snapshot['imdbrating'],
      imageUrl: snapshot['imageurl'],
      videoUrl: snapshot['videourl'],
      maturity: snapshot['maturity'],
      duration: snapshot['duration'],
      description: snapshot['description'],
      genre: snapshot['genre'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJason() => {
        'moviename': movieName,
        'imdbrating': imdbRating,
        'genre': genre,
        'description': description,
        'maturity': maturity,
        'duration': duration,
        'videourl': videoUrl,
        'imageurl': imageUrl,
        'id': id,
        'movieUrl': movieUrl,
      };
}