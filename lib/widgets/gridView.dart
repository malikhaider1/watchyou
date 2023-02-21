import 'package:badges/badges.dart' as badges;
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
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: GridView.builder(
                shrinkWrap: true,
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
                        Positioned(
                            top: 3,
                            left: 14,
                            child: badges.Badge(
                                badgeAnimation:
                                    const badges.BadgeAnimation.rotation(
                                  animationDuration: Duration(seconds: 1),
                                  colorChangeAnimationDuration:
                                      Duration(seconds: 1),
                                  loopAnimation: false,
                                  curve: Curves.fastOutSlowIn,
                                  colorChangeAnimationCurve: Curves.easeInCubic,
                                ),
                                badgeStyle: badges.BadgeStyle(
                                  shape: badges.BadgeShape.square,
                                  badgeColor: Colors.blueGrey.withOpacity(0.1),
                                  padding: const EdgeInsets.all(5),
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                  borderGradient:
                                      const badges.BadgeGradient.linear(
                                          colors: [Colors.red, Colors.black]),
                                  badgeGradient:
                                      const badges.BadgeGradient.linear(
                                    colors: [Colors.blue, Colors.yellow],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  //   borderRadius: BorderRadius.circular(15),
                                  //   badgeContent:
                                  // ),
                                ),
                                child: Text('⭐ ${dataAccessor.imdbRating}',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.7)))))
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
