import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:watchyou/widgets/showsnackbar.dart';

import '../firebaseCrud/firebaseCreateReadUpdateDelete.dart';
import '../firebaseCrud/firebaseJasonData.dart';
import '../screens/DetailInfoScreen.dart';

class KGridView extends StatefulWidget {
  const KGridView({Key? key, required this.collectionName}) : super(key: key);
  final String collectionName;
  @override
  State<KGridView> createState() => _KGridViewState();
}

class _KGridViewState extends State<KGridView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FirebaseJasonData>>(
        stream: FirebaseCreateReadUpdateDelete.read(widget.collectionName),
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

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
              child: GridView.builder(
                itemCount: userData!.length,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  final dataAccessor = userData[index];
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
                                          userData: userData,
                                          index: index,
                                        )));
                          },
                          child: Center(
                            child: Container(
                              height: 150,
                              width: 110,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 0.5,
                                    blurRadius: 1,
                                    color: Colors.grey.withOpacity(0.3),
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
                        Positioned(
                          top: 3,
                          left: 5,
                          child: Badge(
                            toAnimate: true,
                            shape: BadgeShape.square,
                            badgeColor: Colors.blueGrey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            badgeContent: Text('⭐ ${dataAccessor.imdbRating}',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7))),
                          ),
                        )
                      ]));
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
              ),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
