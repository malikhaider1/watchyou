import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchyou/firebaseCrud/firebaseCreateReadUpdateDelete.dart';
import 'package:watchyou/firebaseCrud/firebaseJasonData.dart';
import 'package:watchyou/screens/DetailInfoScreen.dart';
import '../widgets/kAppBar.dart';
import '../widgets/showsnackbar.dart';
import 'LoginPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  int currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blueGrey.withOpacity(0.4),
          selectedItemColor: Colors.blueGrey,
          unselectedItemColor: Colors.white54,
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.heart_fill), label: "Diary"),
          ]),
      appBar: kAppBar(context),
      backgroundColor: Colors.black,
      body: StreamBuilder<List<FirebaseJasonData>>(
          stream: FirebaseCreateReadUpdateDelete.read('action'),
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
              return ListView(
                children: [
                  Column(
                    children: [
                      CarouselSlider.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index, int) {
                            final boardingData = userData![index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            DetailInfoScreen(
                                              userData: userData,
                                              index: index,
                                            )));
                              },
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        color: primaryColor.withOpacity(0.1),
                                      ),
                                    ],
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${boardingData.imageUrl}'),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.rectangle),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              currentIndex = index;
                            },
                            initialPage: currentIndex,
                            autoPlayCurve: Curves.easeInSine,
                            autoPlay: false,
                            enableInfiniteScroll: true,
                            viewportFraction: 0.4,
                            height: 240,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Available Now',
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 15),
                                ),
                                Text(
                                  '${userData![currentIndex].movieName}',
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 19),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.play_circle,
                                  color: Colors.blueGrey,
                                  size: 38,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10),
                    child: Row(
                      children: const [
                        Text(
                          'Action Movie',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const KCarouselSlider(collectionName: 'action'),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blueGrey,
              ),
            );
          }),
    );
  }
}

class KCarouselSlider extends StatelessWidget {
  const KCarouselSlider({Key? key, required this.collectionName})
      : super(key: key);
  final String collectionName;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FirebaseJasonData>>(
        stream: FirebaseCreateReadUpdateDelete.read(collectionName),
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

            return CarouselSlider.builder(
              options: CarouselOptions(
                  enableInfiniteScroll: true,
                  reverse: false,
                  height: 177,
                  viewportFraction: 0.36),
              itemCount: userData!.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final dataAccessor = userData[index];
                return GestureDetector(
                    onTap: () {},
                    child: Stack(children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DetailInfoScreen(
                                        userData: userData,
                                        index: index,
                                      )));
                        },
                        child: Container(
                          height: 175,
                          width: 117,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 2,
                                color: Colors.blueGrey.withOpacity(0.2),
                              ),
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
                      Positioned(
                        top: 5,
                        left: 7,
                        child: Badge(
                          toAnimate: false,
                          shape: BadgeShape.square,
                          badgeColor: Colors.blueGrey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          badgeContent: Text('⭐ ${dataAccessor.imdbRating}',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8))),
                        ),
                      )
                    ]));
              },
            );
          }
          return const CircularProgressIndicator();
        });
  }
}