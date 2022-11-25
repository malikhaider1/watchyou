// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, unused_field, prefer_final_fields, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class ControlsOverlay extends StatefulWidget {
  const ControlsOverlay({Key? key, required this.controller}) : super(key: key);

  final VlcPlayerController controller;

  static const double _playButtonIconSize = 80;
  static const double _replayButtonIconSize = 100;
  static const double _seekButtonIconSize = 30;
  static const Duration _seekStepForward = Duration(seconds: 10);
  static const Duration _seekStepBackward = Duration(seconds: -10);
  static const _playerControlsBgColor = Colors.black87;
  static const Color _iconColor = Colors.white;

  @override
  State<ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<ControlsOverlay> {
  late VlcPlayerController _controller;
  late AnimationController _scaleVideoAnimationController;
  Animation<double> _scaleVideoAnimation =
      const AlwaysStoppedAnimation<double>(1.0);
  double? _targetVideoScale;
  static const _playerControlsBgColor = Colors.black87;

  //
  final double initSnapshotRightPosition = 10;
  final double initSnapshotBottomPosition = 10;
  OverlayEntry? _overlayEntry;

  //
  double sliderValue = 0.0;
  double volumeValue = 50;
  String position = '';
  String duration = '';
  int numberOfCaptions = 0;
  int numberOfAudioTracks = 0;
  bool validPosition = false;

  double recordingTextOpacity = 0;
  DateTime lastRecordingShowTime = DateTime.now();
  bool isRecording = false;

  //
  List<double> playbackSpeeds = [0.5, 1.0, 2.0];
  int playbackSpeedIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.addListener(listener);
  }

  @override
  void dispose() {
    _controller.removeListener(listener);
    _controller.stopRendererScanning();
    super.dispose();
  }

  void listener() async {
    if (!mounted) return;
    //
    if (_controller.value.isInitialized) {
      var oPosition = _controller.value.position;
      var oDuration = _controller.value.duration;
      if (oPosition != null && oDuration != null) {
        if (oDuration.inHours == 0) {
          var strPosition = oPosition.toString().split('.')[0];
          var strDuration = oDuration.toString().split('.')[0];
          position =
              "${strPosition.split(':')[1]}:${strPosition.split(':')[2]}";
          duration =
              "${strDuration.split(':')[1]}:${strDuration.split(':')[2]}";
        } else {
          position = oPosition.toString().split('.')[0];
          duration = oDuration.toString().split('.')[0];
        }
        validPosition = oDuration.compareTo(oPosition) >= 0;
        sliderValue = validPosition ? oPosition.inSeconds.toDouble() : 0;
      }
      numberOfCaptions = _controller.value.spuTracksCount;
      numberOfAudioTracks = _controller.value.audioTracksCount;
      // update recording blink widget
      if (_controller.value.isRecording && _controller.value.isPlaying) {
        if (DateTime.now().difference(lastRecordingShowTime).inSeconds >= 1) {
          lastRecordingShowTime = DateTime.now();
          recordingTextOpacity = 1 - recordingTextOpacity;
        }
      } else {
        recordingTextOpacity = 0;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    bool visible = true;
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 50),
      reverseDuration: Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: () {
          visible = !visible;
        },
        child: Builder(
          builder: (ctx) {
            if (widget.controller.value.isEnded ||
                widget.controller.value.hasError) {
              return Center(
                child: FittedBox(
                  child: IconButton(
                    onPressed: _replay,
                    color: ControlsOverlay._iconColor,
                    iconSize: ControlsOverlay._replayButtonIconSize,
                    icon: Icon(Icons.replay),
                  ),
                ),
              );
            }

            switch (widget.controller.value.playingState) {
              case PlayingState.initialized:
              case PlayingState.paused:
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 0,
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Wrap(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  iconSize: 20,
                                ),
                                Stack(
                                  children: [
                                    IconButton(
                                      tooltip: 'Get Subtitle Tracks',
                                      icon: Icon(Icons.closed_caption),
                                      color: Colors.white,
                                      onPressed: _getSubtitleTracks,
                                      iconSize: 20,
                                    ),
                                    Positioned(
                                      top: 15,
                                      right: 10,
                                      child: IgnorePointer(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(1),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 1,
                                            horizontal: 2,
                                          ),
                                          child: Text(
                                            '$numberOfCaptions',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    IconButton(
                                      tooltip: 'Get Audio Tracks',
                                      icon: Icon(Icons.audiotrack),
                                      color: Colors.white,
                                      onPressed: _getAudioTracks,
                                      iconSize: 20,
                                    ),
                                    Positioned(
                                      top: 15,
                                      right: 10,
                                      child: IgnorePointer(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(1),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 1,
                                            horizontal: 2,
                                          ),
                                          child: Text(
                                            '$numberOfAudioTracks',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => _seekRelative(
                                  ControlsOverlay._seekStepBackward),
                              color: ControlsOverlay._iconColor,
                              iconSize: ControlsOverlay._seekButtonIconSize,
                              icon: Icon(Icons.replay_10),
                            ),
                            IconButton(
                              onPressed: () {
                                if (widget.controller.value.isPlaying) {
                                  _pause();
                                } else {
                                  _play();
                                }
                              },
                              color: ControlsOverlay._iconColor,
                              iconSize: ControlsOverlay._playButtonIconSize,
                              icon: widget.controller.value.isPlaying
                                  ? Icon(Icons.pause)
                                  : Icon(Icons.play_arrow),
                            ),
                            IconButton(
                              onPressed: () => _seekRelative(
                                  ControlsOverlay._seekStepForward),
                              color: ControlsOverlay._iconColor,
                              iconSize: ControlsOverlay._seekButtonIconSize,
                              icon: Icon(Icons.forward_10),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(right: 20),
                          alignment: Alignment.bottomLeft,
                          child: Visibility(
                            visible: true,
                            child: Container(
                              color: _playerControlsBgColor.withOpacity(0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    color: Colors.white,
                                    icon: _controller.value.isPlaying
                                        ? Icon(Icons.pause_circle_outline)
                                        : Icon(Icons.play_circle_outline),
                                    onPressed: _togglePlaying,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          position,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Expanded(
                                          child: Slider(
                                            activeColor: Colors.redAccent,
                                            inactiveColor: Colors.white70,
                                            value: sliderValue,
                                            min: 0.0,
                                            max: (!validPosition &&
                                                    _controller
                                                            .value.duration ==
                                                        null)
                                                ? 1.0
                                                : _controller
                                                    .value.duration.inSeconds
                                                    .toDouble(),
                                            onChanged: validPosition
                                                ? _onSliderPositionChanged
                                                : null,
                                          ),
                                        ),
                                        Text(
                                          duration,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.fullscreen),
                                      color: Colors.white,
                                      onPressed: () async {
                                        // dynamic portraitDown =
                                        //     DeviceOrientation.portraitDown;
                                        // dynamic portraitUp =
                                        //     DeviceOrientation.portraitUp;
                                        // dynamic landscapeLeft =
                                        //     DeviceOrientation.landscapeLeft;
                                        // dynamic landscapeRight =
                                        //     DeviceOrientation.landscapeRight;
                                        setState(() {
                                          // if (portraitUp ==
                                          //         DeviceOrientation
                                          //             .portraitUp ||
                                          //     portraitDown ==
                                          //         DeviceOrientation
                                          //             .portraitDown) {
                                          //   SystemChrome
                                          //       .setPreferredOrientations([
                                          //     DeviceOrientation.landscapeRight,
                                          //     DeviceOrientation.landscapeLeft,
                                          //   ]);
                                          //   SystemChrome.setEnabledSystemUIMode(
                                          //       SystemUiMode.immersiveSticky);
                                          // } else if (landscapeLeft ==
                                          //         DeviceOrientation
                                          //             .landscapeLeft ||
                                          //     landscapeRight ==
                                          //         DeviceOrientation
                                          //             .landscapeRight) {
                                          //   SystemChrome
                                          //       .setPreferredOrientations([
                                          //     DeviceOrientation.portraitUp,
                                          //     DeviceOrientation.portraitDown,
                                          //   ]);
                                          //   SystemChrome.setEnabledSystemUIMode(
                                          //       SystemUiMode.immersiveSticky);
                                          // }
                                          if (DeviceOrientation.portraitUp ==
                                                  DeviceOrientation
                                                      .portraitUp ||
                                              DeviceOrientation.portraitDown ==
                                                  DeviceOrientation
                                                      .portraitDown) {
                                            setState(() {
                                              SystemChrome
                                                  .setPreferredOrientations([
                                                DeviceOrientation
                                                    .landscapeRight,
                                                DeviceOrientation.landscapeLeft,
                                              ]);
                                            });

                                            // SystemChrome.setEnabledSystemUIMode(
                                            //     SystemUiMode.immersiveSticky);
                                          } else if (DeviceOrientation
                                                  .portraitUp !=
                                              DeviceOrientation.portraitUp) {
                                            setState(() {
                                              SystemChrome
                                                  .setPreferredOrientations([
                                                DeviceOrientation.portraitUp,
                                                DeviceOrientation.portraitDown,
                                              ]);
                                            });

                                            // SystemChrome.setEnabledSystemUIMode(
                                            //     SystemUiMode.immersiveSticky);
                                          }
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );

              case PlayingState.buffering:
                return CircularProgressIndicator(
                  semanticsLabel: "Loading",
                  color: Colors.red,
                );
              case PlayingState.playing:
                return GestureDetector(
                  onTap: _pause,
                  child: Container(
                    color: Colors.transparent,
                  ),
                );
              case PlayingState.stopped:
                return GestureDetector(
                  onTap: () {
                    if (visible = true) {
                      visible = false;
                    } else {
                      visible = true;
                    }
                  },
                );
              case PlayingState.ended:
              case PlayingState.error:
                return Center(
                  child: FittedBox(
                    child: IconButton(
                      onPressed: _replay,
                      color: ControlsOverlay._iconColor,
                      iconSize: ControlsOverlay._replayButtonIconSize,
                      icon: Icon(Icons.replay),
                    ),
                  ),
                );

              default:
                return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Future<void> _play() {
    return widget.controller.play();
  }

  Future<void> _replay() async {
    await widget.controller.stop();
    await widget.controller.play();
  }

  Future<void> _pause() async {
    if (widget.controller.value.isPlaying) {
      await widget.controller.pause();
    }
  }

  /// Returns a callback which seeks the video relative to current playing time.
  Future<void> _seekRelative(Duration seekStep) async {
    if (widget.controller.value.duration != null) {
      await widget.controller
          .seekTo(widget.controller.value.position + seekStep);
    }
  }

  void _togglePlaying() async {
    _controller.value.isPlaying
        ? await _controller.pause()
        : await _controller.play();
  }

  void _onSliderPositionChanged(double progress) {
    setState(() {
      sliderValue = progress.floor().toDouble();
    });
    //convert to Milliseconds since VLC requires MS to set time
    _controller.setTime(sliderValue.toInt() * 1000);
  }

  void _getSubtitleTracks() async {
    // if (!_controller.value.isPlaying) return;

    var subtitleTracks = await _controller.getSpuTracks();
    //
    if (subtitleTracks != null && subtitleTracks.isNotEmpty) {
      var selectedSubId = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Subtitle'),
            content: Container(
              width: double.maxFinite,
              height: 250,
              child: ListView.builder(
                itemCount: subtitleTracks.keys.length + 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      index < subtitleTracks.keys.length
                          ? subtitleTracks.values.elementAt(index).toString()
                          : 'Disable',
                    ),
                    onTap: () {
                      Navigator.pop(
                        context,
                        index < subtitleTracks.keys.length
                            ? subtitleTracks.keys.elementAt(index)
                            : -1,
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      );
      if (selectedSubId != null) await _controller.setSpuTrack(selectedSubId);
    }
  }

  void _getAudioTracks() async {
    // if (!_controller.value.isPlaying) return;

    var audioTracks = await _controller.getAudioTracks();
    //
    if (audioTracks != null && audioTracks.isNotEmpty) {
      var selectedAudioTrackId = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Audio'),
            content: Container(
              width: double.maxFinite,
              height: 250,
              child: ListView.builder(
                itemCount: audioTracks.keys.length + 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      index < audioTracks.keys.length
                          ? audioTracks.values.elementAt(index).toString()
                          : 'Disable',
                    ),
                    onTap: () {
                      Navigator.pop(
                        context,
                        index < audioTracks.keys.length
                            ? audioTracks.keys.elementAt(index)
                            : -1,
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      );
      if (selectedAudioTrackId != null) {
        await _controller.setAudioTrack(selectedAudioTrackId);
      }
    }
  }

  void _cyclePlaybackSpeed() async {
    playbackSpeedIndex++;
    if (playbackSpeedIndex >= playbackSpeeds.length) {
      playbackSpeedIndex = 0;
    }
    return await _controller
        .setPlaybackSpeed(playbackSpeeds.elementAt(playbackSpeedIndex));
  }
}
