import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchyou/screens/DetailInfoScreen.dart';
import 'package:watchyou/screens/FirstScreen.dart';

import '../widgets/kAppBar.dart';
import 'GridViewMovies.dart';
import 'comingsoon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  static List bottomBarList = [
    const FirstScreen(),
    const FirstScreen(),
    const ComingSoon(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // backgroundColor: Colors.blueGrey.withOpacity(0.4),
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white54,
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.heart_fill), label: "Diary"),
            BottomNavigationBarItem(
                icon: Icon(Icons.upcoming), label: "Upcoming"),
          ]),
      appBar: kAppBar(context),
      backgroundColor: Colors.black,
      body: bottomBarList[selectedIndex],
    );
  }
}

class HomeMoviesSection extends StatelessWidget {
  const HomeMoviesSection({
    Key? key,
    required this.titleName,
    required this.collectionName,
    required this.list,
  }) : super(key: key);
  final String titleName;
  final String collectionName;
  final List list;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              titleName,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (BuildContext context) => GridViewMoreMovies(
                              // collectionName: collectionName,
                              list: list,
                            )));
              },
              icon: const Icon(
                Icons.read_more_outlined,
                color: Colors.grey,
              ))
        ],
      ),
    );
  }
}

class KCarouselSlider extends StatelessWidget {
  const KCarouselSlider(
      {Key? key,
      required this.collectionName,
      required this.collectionCondition,
      required this.list})
      : super(key: key);
  final String collectionName;
  final String collectionCondition;
  final List list;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return CarouselSlider.builder(
        options: CarouselOptions(
            enableInfiniteScroll: true,
            reverse: false,
            height: height / (5.579),
            viewportFraction: 0.32),
        // viewportFraction: 0.32),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          // final dataAccessor = userData[index];
          {
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
                                    userData: list[index],
                                  )));
                    },
                    child: Container(
                      height: height / (5.579),
                      width: width / (3.9),
                      // width: width / (2.805),
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
                              '${list[index].imageUrl}',
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
                      badgeContent: Text('⭐ ${list[index].imdbRating}',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8))),
                    ),
                  )
                ]));
          }
          return const SizedBox();
        });

    // StreamBuilder<List<FirebaseJasonData>>(
    //     stream: FirebaseCreateReadUpdateDelete.read(collectionName),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       if (snapshot.hasError) {
    //         showSnackBar("Something Went Wrong", context);
    //       }
    //       if (snapshot.hasData) {
    //         final userData = snapshot.data;
    //         List action=[],horror=[],comedy=[],animation=[],family=[],sci=[];
    //
    //         for(final movie in userData!){
    //
    //           if(movie.genre!.contains('animation')){
    //             action.add(movie);
    //           }
    //
    //         }
    //         Column(children: [
    //
    //         ],);
    //
    //
    //       }
    //
    //       return const CircularProgressIndicator(
    //         color: Colors.red,
    //       );
    //     });
  }
}
