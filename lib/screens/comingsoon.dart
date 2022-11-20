import 'package:flutter/material.dart';
import 'package:watchyou/firebaseCrud/firebaseJasonData.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../firebaseCrud/firebaseCreateReadUpdateDelete.dart';
import '../widgets/showsnackbar.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<List<FirebaseJasonData>>(
          stream: FirebaseCreateReadUpdateDelete.read('action'),
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
              final movieData = snapshot.data;
              return ListView.builder(
                  itemCount: movieData!.length,
                  itemBuilder: (context, index) {
                    final boardingData = movieData[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: Text(
                              '${boardingData.duration}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 160,
                                color: Colors.blueGrey,
                                child: YoutubePlayer(
                                  // thumbnail: Image.network(
                                  //   "${boardingData.imageUrl}",
                                  //   fit: BoxFit.cover,
                                  // ),
                                  controlsTimeOut: const Duration(seconds: 5),
                                  bottomActions: [
                                    ProgressBar(isExpanded: true),
                                    RemainingDuration(),
                                  ],
                                  bufferIndicator:
                                      const CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                  aspectRatio: 16 / 9,
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: Colors.blueGrey,
                                  width: MediaQuery.of(context).size.width - 70,
                                  progressColors: const ProgressBarColors(
                                      handleColor: Colors.white60,
                                      playedColor: Colors.blueGrey),
                                  controller: YoutubePlayerController(
                                      flags: const YoutubePlayerFlags(
                                        autoPlay: false,
                                      ),
                                      initialVideoId:
                                          "${boardingData.videoUrl}"),
                                ),
                              ),
                              Text(
                                "${boardingData.movieName}",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                "${boardingData.duration}",
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 70,
                                child: Text(
                                  "${boardingData.description}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      overflow: TextOverflow.clip),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "${boardingData.genre}",
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
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
