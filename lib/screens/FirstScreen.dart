import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchyou/screens/single_tab.dart';

import '../firebaseCrud/firebaseCreateReadUpdateDelete.dart';
import '../firebaseCrud/firebaseJasonData.dart';
import '../widgets/showsnackbar.dart';
import 'DetailInfoScreen.dart';
import 'LoginPage.dart';
import 'homescreen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    late FirebaseJasonData jasonData;
    return StreamBuilder<List<FirebaseJasonData>>(
        stream: FirebaseCreateReadUpdateDelete.read('movies'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (snapshot.hasError) {
            showSnackBar("Something Went Wrong", context);
          }
          if (snapshot.hasData) {
            final userData = snapshot.data;

            List action = [],
                horror = [],
                comedy = [],
                animation = [],
                family = [],
                sciFi = [],
                romance = [],
                fantasy = [];

            for (final movie in userData!) {
              if (movie.genre!.toLowerCase().contains('animation')) {
                animation.add(movie);
              }
              if (movie.genre!.toLowerCase().contains('action')) {
                action.add(movie);
              }
              if (movie.genre!.toLowerCase().contains('horror')) {
                horror.add(movie);
              }
              if (movie.genre!.toLowerCase().contains('comedy')) {
                comedy.add(movie);
              }
              if (movie.genre!.toLowerCase().contains('family')) {
                family.add(movie);
              }
              if (movie.genre!.toLowerCase().contains('sci-fi')) {
                sciFi.add(movie);
              }
              if (movie.genre!.toLowerCase().contains('romance')) {
                romance.add(movie);
              }
              if (movie.genre!.toLowerCase().contains('fantasy')) {
                fantasy.add(movie);
              }
            }
            return ListView(
              children: [
                Column(
                  children: [
                    CarouselSlider.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index, int) {
                          final boardingData = userData[index];
                          jasonData = boardingData;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          DetailInfoScreen(
                                            userData: boardingData,
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
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          viewportFraction: 0.4,
                          height: MediaQuery.of(context).size.height / (3.254),
                          enlargeCenterPage: true,
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
                                    color: Colors.grey.shade700, fontSize: 15),
                              ),
                              Text(
                                '${userData[currentIndex].movieName}',
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 19),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SingleTab(
                                              userData: jasonData,
                                            )));
                              },
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
                HomeMoviesSection(
                  collectionName: 'movies',
                  titleName: 'Action',
                  list: action,
                ),
                KCarouselSlider(
                  collectionName: 'movies',
                  collectionCondition: 'action',
                  list: action,
                ),
                HomeMoviesSection(
                  titleName: 'Horror',
                  collectionName: 'movies',
                  list: horror,
                ),
                KCarouselSlider(
                  collectionName: 'movies',
                  collectionCondition: 'horror',
                  list: horror,
                ),
                HomeMoviesSection(
                  titleName: 'Comedies',
                  collectionName: 'movies',
                  list: comedy,
                ),
                KCarouselSlider(
                  collectionName: 'movies',
                  collectionCondition: 'comedy',
                  list: comedy,
                ),
                HomeMoviesSection(
                  titleName: 'Family',
                  collectionName: 'movies',
                  list: family,
                ),
                KCarouselSlider(
                  collectionName: 'movies',
                  collectionCondition: 'family',
                  list: comedy,
                ),
                HomeMoviesSection(
                  titleName: 'Animation',
                  collectionName: 'movies',
                  list: animation,
                ),
                KCarouselSlider(
                  collectionName: 'movies',
                  collectionCondition: 'animation',
                  list: animation,
                ),
                HomeMoviesSection(
                  titleName: 'Sci-Fi',
                  collectionName: 'movies',
                  list: sciFi,
                ),
                KCarouselSlider(
                  collectionName: 'movies',
                  collectionCondition: 'sci-fi',
                  list: sciFi,
                ),
                HomeMoviesSection(
                  titleName: 'Romantic',
                  collectionName: 'movies',
                  list: romance,
                ),
                KCarouselSlider(
                  collectionName: 'movies',
                  collectionCondition: 'romance',
                  list: romance,
                ),
                HomeMoviesSection(
                  titleName: 'Fantasy',
                  collectionName: 'movies',
                  list: fantasy,
                ),
                KCarouselSlider(
                  collectionName: 'movies',
                  collectionCondition: 'fantasy',
                  list: fantasy,
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blueGrey,
            ),
          );
        });
  }
}
