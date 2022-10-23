// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
//
// import '../firebaseCrud/firebaseJasonData.dart';
//
// class PlayingScreen extends StatefulWidget {
//   const PlayingScreen(
//       {Key? key,
//       this.userData,
//       required this.index,
//       required this.controller,
//       this.showControls = true})
//       : super(key: key);
//
//   final List<FirebaseJasonData>? userData;
//   final int index;
//   final VlcPlayerController controller;
//   final bool showControls;
//
//   @override
//   State<PlayingScreen> createState() => _PlayingScreenState();
// }
//
// class _PlayingScreenState extends State<PlayingScreen>
//     with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
//   bool isPlaying = true;
//   static const _playerControlsBgColor = Colors.black87;
//
//   late VlcPlayerController _controller;
//   late AnimationController _scaleVideoAnimationController;
//   final Animation<double> _scaleVideoAnimation =
//       const AlwaysStoppedAnimation<double>(1.0);
//   double? _targetVideoScale;
//
//   OverlayEntry? _overlayEntry;
//
//   //
//   double sliderValue = 0.0;
//   double volumeValue = 100;
//   String position = '';
//   String duration = '';
//   int numberOfCaptions = 0;
//   int numberOfAudioTracks = 0;
//   bool validPosition = false;
//
//   double recordingTextOpacity = 0;
//   DateTime lastRecordingShowTime = DateTime.now();
//   bool isRecording = false;
//
//   void _forceLandscape() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//   }
//
//   VlcPlayerController vlcPlayerController = VlcPlayerController.network('',
//       hwAcc: HwAcc.full,
//       autoPlay: true,
//       autoInitialize: true,
//       options: VlcPlayerOptions(
//         subtitle: VlcSubtitleOptions([]),
//         video: VlcVideoOptions([]),
//         advanced: VlcAdvancedOptions([]),
//       ));
//
//   @override
//   void initState() {
//     _controller = widget.controller;
//     _controller.addListener(listener);
//     _forceLandscape();
//
//     vlcPlayerController = VlcPlayerController.network(
//         '${widget.userData![widget.index].movieUrl}');
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.removeListener(listener);
//     _controller.stopRendererScanning();
//     vlcPlayerController.dispose();
//     super.dispose();
//   }
//
//   void listener() async {
//     if (!mounted) return;
//     //
//     if (_controller.value.isInitialized) {
//       var oPosition = _controller.value.position;
//       var oDuration = _controller.value.duration;
//       if (oPosition != null && oDuration != null) {
//         if (oDuration.inHours == 0) {
//           var strPosition = oPosition.toString().split('.')[0];
//           var strDuration = oDuration.toString().split('.')[0];
//           position =
//               "${strPosition.split(':')[1]}:${strPosition.split(':')[2]}";
//           duration =
//               "${strDuration.split(':')[1]}:${strDuration.split(':')[2]}";
//         } else {
//           position = oPosition.toString().split('.')[0];
//           duration = oDuration.toString().split('.')[0];
//         }
//         validPosition = oDuration.compareTo(oPosition) >= 0;
//         sliderValue = validPosition ? oPosition.inSeconds.toDouble() : 0;
//       }
//       numberOfCaptions = _controller.value.spuTracksCount;
//       numberOfAudioTracks = _controller.value.audioTracksCount;
//       // update recording blink widget
//       if (_controller.value.isRecording && _controller.value.isPlaying) {
//         if (DateTime.now().difference(lastRecordingShowTime).inSeconds >= 1) {
//           lastRecordingShowTime = DateTime.now();
//           recordingTextOpacity = 1 - recordingTextOpacity;
//         }
//       } else {
//         recordingTextOpacity = 0;
//       }
//
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//
//     return WillPopScope(
//       onWillPop: () async {
//         final shouldPop = await showWarning(context);
//         return shouldPop ?? false;
//       },
//       child: Stack(
//         children: [
//           Container(
//             // Background behind the video
//             color: Colors.black,
//           ),
//           Center(
//             child: AspectRatio(
//               aspectRatio: 16 / 9,
//               child: VlcPlayer(
//                 controller: vlcPlayerController,
//                 aspectRatio: screenSize.width / screenSize.height,
//                 placeholder: const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.blueGrey,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<bool?> showWarning(BuildContext context) async {
//     return showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               title: const Text('Do you want to Exit'),
//               actions: [
//                 ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context, false);
//                     },
//                     child: const Text("NO")),
//                 ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context, true);
//                     },
//                     child: const Text("YES")),
//               ],
//             ));
//   }
//
//   @override
//   bool get wantKeepAlive => true;
// }