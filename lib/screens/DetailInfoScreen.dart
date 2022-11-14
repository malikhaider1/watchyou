import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchyou/screens/single_tab.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../assets/authwithgoogle.dart';
import '../firebaseCrud/firebaseJasonData.dart';
import '../widgets/gridView.dart';

class DetailInfoScreen extends StatefulWidget {
  const DetailInfoScreen({Key? key, this.userData, required this.index})
      : super(key: key);
  final List<FirebaseJasonData>? userData;
  final int index;

  @override
  State<DetailInfoScreen> createState() => _DetailInfoScreenState();
}

YoutubePlayerController _controller = YoutubePlayerController(
  initialVideoId: "",
);

class _DetailInfoScreenState extends State<DetailInfoScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: "${widget.userData![widget.index].videoUrl}",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.blueGrey,
        ),
        backgroundColor: Colors.transparent,
        title: FirebaseAuth.instance.currentUser?.displayName != null
            ? Text(
                "${FirebaseAuth.instance.currentUser!.displayName}",
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis),
              )
            : Image.asset(
                'images/watchyouinnerlogo.png',
                color: Colors.blueGrey,
                height: 80,
                width: 80,
              ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.search,
                color: Colors.blueGrey,
              )),
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          content: TextButton(
                              onPressed: () {
                                setState(() {
                                  signOut();
                                  Navigator.pop(context);
                                });
                              },
                              child: const Text(
                                "Confirm",
                                style: TextStyle(color: Colors.white54),
                              )),
                          backgroundColor: Colors.black54,
                          title: const Text(
                            "Sign out",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ));
              },
              child: const Text(
                "Sign Out",
                style: TextStyle(color: Colors.blueGrey),
              ))
        ],
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Container(
            height: 250,
            color: Colors.blueGrey,
            child: YoutubePlayer(
              controlsTimeOut: const Duration(seconds: 5),
              bottomActions: [
                ProgressBar(isExpanded: true),
                RemainingDuration(),
              ],
              bufferIndicator: const CircularProgressIndicator(
                color: Colors.blueGrey,
              ),
              aspectRatio: 16 / 9,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueGrey,
              width: MediaQuery.of(context).size.width,
              progressColors: const ProgressBarColors(
                  handleColor: Colors.white60, playedColor: Colors.blueGrey),
              controller: _controller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                SizedBox(
                  width: 260,
                  child: Text(
                    "${widget.userData![widget.index].movieName}",
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 21),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.userData![widget.index].duration!.substring(6),
                  style: const TextStyle(color: Colors.grey, fontSize: 21),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 35,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "${widget.userData![widget.index].maturity}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 50,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "HD",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "⭐${widget.userData![widget.index].imdbRating}",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 16),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () async {
                      // if () {
                      //   return await FirebaseCreateReadUpdateDelete.create(
                      //       FirebaseJasonData(
                      //         maturity: ,
                      //         duration: ,
                      //         description: ,
                      //         genre: ,
                      //         videoUrl:,
                      //         imageUrl: ,
                      //         movieName: ,
                      //         imdbRating:,
                      //         movieUrl: ,
                      //       ),
                      //       context,
                      //       "addtodiary");
                      // }
                    },
                    icon: const Icon(CupertinoIcons.add),
                    color: Colors.white,
                  ),
                  Text(
                    "Add to Diary",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 15),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      if (_controller.initialVideoId != null) {
                        setState(() {
                          _controller.pause();
                        });

                        // Get.to(() => SingleTab(
                        //       index: widget.index,
                        //       userData: widget.userData,
                        //     ));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => SingleTab(
                                      index: widget.index,
                                      userData: widget.userData,
                                    )));
                      }
                    },
                    icon: const Icon(CupertinoIcons.play_fill),
                    color: Colors.white,
                  ),
                  Text(
                    "Play",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Genre",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 19),
                ),
                Text(
                  "${widget.userData![widget.index].genre} - ${widget.userData![widget.index].duration!.substring(0, 6)}",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 13),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 19),
                ),
                Text(
                  "${widget.userData![widget.index].description}",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 13),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            height: 60,
            child: TabBar(
                controller: tabController,
                indicatorColor: Colors.red.withOpacity(0.7),
                indicatorWeight: 2.2,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(
                    text: "Similar",
                  ),
                  Tab(
                    text: "More",
                  ),
                ]),
          ),
          SizedBox(
            height: 300,
            child: TabBarView(controller: tabController, children: [
              KGridView(
                collectionName:
                    widget.userData![widget.index].genre!.contains('action')
                        ? 'action'
                        : 'action',
              ),
              const Text("More"),
            ]),
          )
        ],
      ),
    );
  }
}
