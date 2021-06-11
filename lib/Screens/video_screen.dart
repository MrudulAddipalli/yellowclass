import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import './camera_live_preview.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController _videoController =
      VideoPlayerController.asset("assets/videoplayback.mp4");

  bool isPlaying = false;
  bool isAudioMuted = false;
  bool showControls = false;
  double volumnFactor = 100;

  @override
  void initState() {
    super.initState();
    _videoController.initialize().then((_) {
      setState(() {
        _videoController.play();
        isPlaying = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      // color: showControls ? Colors.white : Colors.black,
      color: Colors.black,
      child: Stack(
        children: [
          _videoController.value.isInitialized
              ? GestureDetector(
                  onTap: () {
                    print("GestureDetector");
                    setState(() {
                      showControls = !showControls;
                    });
                  },
                  //
                  onVerticalDragUpdate: (details) {
                    if (details.delta.dy < 0) {
                      print("increase volumn");
                      if (volumnFactor < 100.0) {
                        volumnFactor += 5;
                      }
                    } else {
                      print("reduce volumn");
                      if (volumnFactor > 0.0) {
                        volumnFactor -= 5;
                      }
                    }
                    setState(() {
                      showControls = true;
                      _videoController.setVolume(volumnFactor / 100);
                    });

                    print(volumnFactor);
                  },

                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: VideoPlayer(_videoController),
                        ),
                      ),
                      if (showControls) Container(color: Colors.black45),
                      if (showControls)
                        Positioned(
                          top: MediaQuery.of(context).size.height / 2 - 25,
                          left: MediaQuery.of(context).size.width / 2 - 25,
                          child: isPlaying
                              ? IconButton(
                                  padding: EdgeInsets.only(),
                                  icon: Icon(Icons.pause,
                                      size: 50, color: Colors.white),
                                  onPressed: () {
                                    print("pause");
                                    _videoController.pause();
                                    setState(() {
                                      isPlaying = false;
                                      // showControls = !showControls;
                                    });
                                  },
                                )
                              : IconButton(
                                  padding: EdgeInsets.only(),
                                  icon: Icon(Icons.play_arrow,
                                      size: 50, color: Colors.white),
                                  onPressed: () {
                                    print("play");
                                    _videoController.play();
                                    setState(() {
                                      isPlaying = true;
                                      // showControls = !showControls;
                                    });
                                  },
                                ),
                        ),
                      if (showControls)
                        Align(
                          alignment: Alignment.center,
                          child: AspectRatio(
                            aspectRatio: _videoController.value.aspectRatio,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (isAudioMuted) {
                                          _videoController
                                              .setVolume(volumnFactor / 100);
                                        } else {
                                          _videoController.setVolume(0);
                                        }
                                      });
                                      isAudioMuted = !isAudioMuted;
                                    },
                                    child: SizedBox(
                                      width: 50,
                                      height: 60,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          isAudioMuted || volumnFactor == 0
                                              ? Image.asset(
                                                  "speaker_mute.png",
                                                  height: 20,
                                                  width: 20,
                                                )
                                              : Image.asset(
                                                  "speaker_on.png",
                                                  height: 25,
                                                  width: 25,
                                                ),
                                          Text(
                                            isAudioMuted
                                                ? "0%"
                                                : "${volumnFactor.toInt()}%",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: VideoProgressIndicator(
                                          _videoController,
                                          allowScrubbing: true,
                                          padding: const EdgeInsets.all(15),
                                        ),
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.only(),
                                        icon: Icon(Icons.crop_rotate,
                                            size: 25, color: Colors.white),
                                        onPressed: () {
                                          print("Rotate");
                                          if (MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.landscape) {
                                            SystemChrome
                                                .setPreferredOrientations([
                                              DeviceOrientation.portraitUp,
                                            ]);
                                          } else {
                                            SystemChrome
                                                .setPreferredOrientations([
                                              DeviceOrientation.landscapeLeft,
                                            ]);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          CameraLivePreviewScreen(
            top: MediaQuery.of(context).size.height - 150,
            left: MediaQuery.of(context).size.width - 100 - 10,
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
}
