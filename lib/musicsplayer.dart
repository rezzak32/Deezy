import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class MusicPlayerWidget extends StatelessWidget {
  final MyController controller;
  final List<dynamic> tracks;

  const MusicPlayerWidget({
    Key? key,
    required this.controller,
    required this.tracks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              tracks[controller.currentTrackIndex.value]['title_short'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous),
                onPressed: () {
                  controller.previousTrack();
                },
              ),
              Obx(
                () => IconButton(
                  icon: controller.isPlaying.value &&
                          controller.currentTrackIndex.value != -1
                      ? Icon(Icons.pause)
                      : Icon(Icons.play_arrow),
                  onPressed: () {
                    if (controller.isPlaying.value &&
                        controller.currentTrackIndex.value != -1) {
                      controller.pause();
                    } else {
                      controller.play(
                          tracks[controller.currentTrackIndex.value]['preview'],
                          controller.currentTrackIndex.value);
                    }
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.skip_next),
                onPressed: () {
                  controller.nextTrack();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
