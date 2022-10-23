// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class FireBaseManagements {
//   FireBaseManagements();
//
//   Future createMovie(
//       {required BuildContext context,
//       required String collectionName,
//       required String movieName,
//       required String imdbRating,
//       required String description,
//       required String maturity,
//       required String duration,
//       required String videoUrl,
//       required String imageUrl}) async {
//     final userCollection =
//         FirebaseFirestore.instance.collection(collectionName);
//     final docRef = userCollection.doc();
//     await docRef.set({
//       "movieName": movieName,
//       "imdbRating": imdbRating,
//       "description": description,
//       "maturity": maturity,
//       "duration": duration,
//       "videoUrl": videoUrl,
//       "imageUrl": imageUrl,
//     });
//   }
// }