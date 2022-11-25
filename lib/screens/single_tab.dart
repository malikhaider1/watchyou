// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, avoid_print, sized_box_for_whitespace, prefer_const_constructors, use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import '../firebaseCrud/firebaseJasonData.dart';
import 'video_data.dart';
import 'vlc_player_with_controls.dart';

class SingleTab extends StatefulWidget {
  const SingleTab({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final FirebaseJasonData userData;

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
      path: '${widget.userData!.movieUrl}',
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
              VlcAdvancedOptions.networkCaching(1500),
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
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _controller.stopRendererScanning();
    await _controller.dispose();
  }
}
