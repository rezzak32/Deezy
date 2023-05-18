import 'package:deezy/apiservice.dart';
import 'package:flutter/material.dart';

import 'trackspage.dart';


class AlbumsPage extends StatelessWidget {
  final int artistId;
  final String artistName;
  final List<dynamic> albums;

  const AlbumsPage(
      {Key? key, required this.artistId, required this.artistName, required this.albums})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artistName),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: albums.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              List<dynamic> tracks = await APIService.fetchPlaylistsByAlbum(albums[index]['id']);
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TracksPage(
                    albumId: albums[index]['id'],
                    albumName: albums[index]['title'],
                    tracks: tracks,
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      albums[index]['cover_medium'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(albums[index]['title']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}