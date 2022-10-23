import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:watchyou/firebaseCrud/firebaseJasonData.dart';
import 'package:watchyou/widgets/showsnackbar.dart';

class FirebaseCreateReadUpdateDelete {
  static Stream<List<FirebaseJasonData>> read(String collectionName) {
    final userCollection =
        FirebaseFirestore.instance.collection(collectionName);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => FirebaseJasonData.fromJason(e)).toList());
  }

  static Future create(FirebaseJasonData firebaseJasonData,
      BuildContext context, String collectionName) async {
    final userCollection =
        FirebaseFirestore.instance.collection(collectionName);
    final uid = userCollection.doc().id;
    final docRef = userCollection.doc(uid);

    final newCreate = FirebaseJasonData(
      movieUrl: firebaseJasonData.movieUrl,
      movieName: firebaseJasonData.movieName,
      imdbRating: firebaseJasonData.imdbRating,
      imageUrl: firebaseJasonData.imageUrl,
      description: firebaseJasonData.description,
      duration: firebaseJasonData.duration,
      maturity: firebaseJasonData.maturity,
      videoUrl: firebaseJasonData.videoUrl,
      genre: firebaseJasonData.genre,
      id: uid,
    ).toJason();

    try {
      await docRef.set(newCreate);
      showSnackBar('Upload Successfully', context);
    } catch (e) {
      showSnackBar("$e", context);
    }
  }

  static Future update(FirebaseJasonData firebaseJasonData,
      BuildContext context, String collectionName) async {
    final userCollection =
        FirebaseFirestore.instance.collection(collectionName);
    final docRef = userCollection.doc(firebaseJasonData.id);

    final newCreate = FirebaseJasonData(
      movieUrl: firebaseJasonData.movieUrl,
      movieName: firebaseJasonData.movieName,
      imdbRating: firebaseJasonData.imdbRating,
      imageUrl: firebaseJasonData.imageUrl,
      description: firebaseJasonData.description,
      duration: firebaseJasonData.duration,
      maturity: firebaseJasonData.maturity,
      videoUrl: firebaseJasonData.videoUrl,
      genre: firebaseJasonData.genre,
      id: firebaseJasonData.id,
    ).toJason();

    try {
      await docRef.update(newCreate);
      showSnackBar('Upload updated', context);
    } catch (e) {
      showSnackBar("$e", context);
    }
  }

  static Future delete(FirebaseJasonData firebaseJasonData,
      BuildContext context, String collectionName) async {
    final userCollection =
        FirebaseFirestore.instance.collection(collectionName);
    final docRef = userCollection.doc(firebaseJasonData.id).delete();

    try {
      showSnackBar('Deleted Successfully', context);
    } catch (e) {
      showSnackBar("$e", context);
    }
  }
}