import 'dart:convert';

import 'package:deezy/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class APIService {

  static Future<List<dynamic>> genreapi() async {
  final response = await get(Uri.parse('https://api.deezer.com/genre'));

  try {
    final controller = Get.find<MyController>();
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      controller.genres.value = jsonResponse['data'];
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to load genres');
    }
  } catch (e) {
    debugPrint('Error while fetching genres: $e');
    return [];
  } finally {
    //controller.isLoading.value = false;
  }
}

  static fetchArtistsByGenre(int genreId) async {
    final controller = Get.find<MyController>();
    try {
      var response =
          await get(Uri.parse('https://api.deezer.com/genre/$genreId/artists'));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var artists = jsonResponse['data'];
        controller.artists.value = artists;
      } else {
        throw Exception('Failed to load artists');
      }
    } catch (e) {
      debugPrint('Error while fetching artists: $e');
    } finally {
      controller.isLoading.value = false;
    }
  }
  
  static Future<List<dynamic>> fetchAlbumsByArtist(int artistId) async {
  try {
    final response = await get(Uri.parse('https://api.deezer.com/artist/$artistId/albums'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to load albums');
    }
  } catch (e) {
    debugPrint('Error while fetching albums: $e');
    rethrow;
  }
}
static Future<List<dynamic>> fetchPlaylistsByAlbum(int albumId) async {
  try {
    final response = await get(Uri.parse('https://api.deezer.com/album/$albumId/tracks'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to load playlists');
    }
  } catch (e) {
    debugPrint('Error while fetching playlists: $e');
    rethrow;
  }
}
static Future<void> playSong(int songId) async {
  try {
    final response = await get(Uri.parse('https://api.deezer.com/track/$songId'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String previewUrl = jsonResponse['preview'];
      
      final controller = Get.find<MyController>();
      int index = controller.tracks.indexWhere((track) => track['id'] == songId);
      
      if (index != -1) {
        controller.play(previewUrl, index);
      }
    } else {
      throw Exception('Failed to load song');
    }
  } catch (e) {
    debugPrint('Error while playing song: $e');
    rethrow;
  }
}
}