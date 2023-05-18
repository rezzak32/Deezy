import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'apiservice.dart';

class MyController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var isLoading = false.obs;
  var genres = [].obs;
  var artists = [].obs;
  var songs = [].obs;
  var albums = [].obs;
  List<dynamic> tracks = [];
  
  RxInt currentTrackIndex = (-1).obs;

  @override
  void onInit() {
    fetchGenres();
    super.onInit();
  }

  void fetchGenres() async {
    try {
      var _genres = await APIService.genreapi();
      genres.value = _genres;
      fetchAllArtists();
    } catch (e) {
      debugPrint('Error while fetching genres: $e');
    }
  }

  void fetchAllArtists() async {
    try {
      final artistsByGenre = await Future.wait(genres.map((genre) async {
        var _artists = await APIService.fetchArtistsByGenre(genre['id']);
        return _artists;
      }));
      artists.value = artistsByGenre.expand((x) => x).toList();
    } catch (e) {
      debugPrint('Error while fetching artists: $e');
    }
  }

  void setTracks(List<dynamic> newTracks) {
    tracks = newTracks;
  }

  void play(String previewUrl, int index) async {
    if (isPlaying.value) {
      await audioPlayer.stop();
    }

    if (tracks.isNotEmpty) {
      await audioPlayer.play(UrlSource(previewUrl));
      isPlaying.value = true;
      currentTrackIndex.value = index;
    }
  }

  void pause() async {
    await audioPlayer.pause();
    isPlaying.value = false;
  }

  void previousTrack() {
    if (tracks.isNotEmpty) {
      if (currentTrackIndex.value > 0) {
        int previousIndex = currentTrackIndex.value - 1;
        play(tracks[previousIndex]['preview'], previousIndex);
      } else {
        int lastIndex = tracks.length - 1;
        play(tracks[lastIndex]['preview'], lastIndex);
      }
    }
  }

  void nextTrack() {
    if (tracks.isNotEmpty) {
      if (currentTrackIndex.value < tracks.length - 1) {
        int nextIndex = currentTrackIndex.value + 1;
        play(tracks[nextIndex]['preview'], nextIndex);
      } else {
        play(tracks[0]['preview'], 0);
      }
    }
  }
}
