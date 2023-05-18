import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'musicsplayer.dart';

class TracksPage extends StatelessWidget {
  final int albumId;
  final String albumName;
  final List<dynamic> tracks;

  const TracksPage({
    Key? key,
    required this.albumId,
    required this.albumName,
    required this.tracks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyController());
controller.setTracks(tracks);
    return Scaffold(
      appBar: AppBar(
        title: Text(albumName),
      ),
      body: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return MusicPlayerWidget(
                controller: controller,
                tracks: tracks,
              );
            },
          );
        },
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: tracks.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(tracks[index]['title']),
              // trailing: Obx(
              //   () => IconButton(
              //     icon: controller.isPlaying.value &&
              //             controller.currentTrackIndex.value == index
              //         ? Icon(Icons.pause)
              //         : Icon(Icons.play_arrow),
              //     onPressed: () {
              //       if (controller.isPlaying.value &&
              //           controller.currentTrackIndex.value == index) {
              //         controller.pause();
              //       } else {
              //         controller.play(tracks[index]['preview'], index);
              //       }
              //     },
              //   ),
              // ),
            );
          },
        ),
      ),
    );
  }
}
