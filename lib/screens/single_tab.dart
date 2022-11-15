// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, avoid_print, sized_box_for_whitespace, prefer_const_constructors, use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import '../firebaseCrud/firebaseJasonData.dart';
import 'video_data.dart';
import 'vlc_player_with_controls.dart';

class SingleTab extends StatefulWidget {
  const SingleTab({Key? key, this.userData, required this.index})
      : super(key: key);

  final List<FirebaseJasonData>? userData;
  final int index;

  @override
  _SingleTabState createState() => _SingleTabState();
}

class _SingleTabState extends State<SingleTab> {
  late VlcPlayerController _controller;
  final _key = GlobalKey<VlcPlayerWithControlsState>();

  //
  late List<VideoData> listVideos;
  late int selectedVideoIndex;

  void fillVideos() {
    listVideos = <VideoData>[];
    //
    listVideos.add(VideoData(
      path: '${widget.userData![widget.index].movieUrl}',
      type: VideoType.network,
    ));
  }

  @override
  void initState() {
    super.initState();

    //
    fillVideos();
    selectedVideoIndex = 0;
    //
    var initVideo = listVideos[selectedVideoIndex];
    switch (initVideo.type) {
      case VideoType.network:
        _controller = VlcPlayerController.network(
          initVideo.path,
          hwAcc: HwAcc.full,
          options: VlcPlayerOptions(
            advanced: VlcAdvancedOptions([
              VlcAdvancedOptions.networkCaching(2000),
            ]),
            subtitle: VlcSubtitleOptions([
              VlcSubtitleOptions.boldStyle(false),
              VlcSubtitleOptions.fontSize(31),
              // VlcSubtitleOptions.outlineColor(VlcSubtitleColor.white),
              // VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.thin),
              // works only on externally added subtitles
              VlcSubtitleOptions.color(VlcSubtitleColor.white),
            ]),
            http: VlcHttpOptions([
              VlcHttpOptions.httpReconnect(true),
            ]),
            rtp: VlcRtpOptions([
              VlcRtpOptions.rtpOverRtsp(true),
            ]),
          ),
        );
        break;
    }
    _controller.addOnInitListener(() async {
      await _controller.startRendererScanning();
    });
    _controller.addOnRendererEventListener((type, id, name) {
      print('OnRendererEventListener $type $id $name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black12,
      child: VlcPlayerWithControls(
        key: _key,
        controller: _controller,
        // onStopRecording: (recordPath) {
        //   setState(() {
        //     listVideos.add(VideoData(
        //       name: 'Recorded Video',
        //       path: recordPath,
        //       type: VideoType.network,
        //     ));
        //   });
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(
        //           'The recorded video file has been added to the end of list.'),
        //     ),
        //   );
        // },
      ),
    );
    // ListView.builder(
    //   shrinkWrap: true,
    //   itemCount: listVideos.length,
    //   physics: NeverScrollableScrollPhysics(),
    //   itemBuilder: (BuildContext context, int index) {
    //     var video = listVideos[index];
    //     IconData iconData;
    //     switch (video.type) {
    //       case VideoType.network:
    //         iconData = Icons.cloud;
    //         break;
    //     }
    //     return ListTile(
    //       dense: true,
    //       selected: selectedVideoIndex == index,
    //       selectedTileColor: Colors.black54,
    //       leading: Icon(
    //         iconData,
    //         color:
    //             selectedVideoIndex == index ? Colors.white : Colors.black,
    //       ),
    //       title: Text(
    //         video.name,
    //         overflow: TextOverflow.ellipsis,
    //         style: TextStyle(
    //           color:
    //               selectedVideoIndex == index ? Colors.white : Colors.black,
    //         ),
    //       ),
    //       subtitle: Text(
    //         video.path,
    //         overflow: TextOverflow.ellipsis,
    //         style: TextStyle(
    //           color:
    //               selectedVideoIndex == index ? Colors.white : Colors.black,
    //         ),
    //       ),
    //       onTap: () async {
    //         await _controller.stopRecording();
    //         switch (video.type) {
    //           case VideoType.network:
    //             await _controller.setMediaFromNetwork(
    //               video.path,
    //               hwAcc: HwAcc.full,
    //             );
    //             break;
    //         }
    //         setState(() {
    //           selectedVideoIndex = index;
    //         });
    //       },
    //     );
    //   },
    // ),
    //   ],
    // );
  }

  @override
  void dispose() async {
    super.dispose();
    await _controller.stopRecording();
    await _controller.stopRendererScanning();
    await _controller.dispose();
  }
}
