import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'apiservice.dart';
import 'albumspage.dart';

class ArtistPage extends StatelessWidget {
  final int genreId;
  final String genreName;
  final artistController = Get.put<MyController>(MyController());

  ArtistPage({Key? key, required this.genreId, required this.genreName})
      : super(key: key) {
    APIService.fetchArtistsByGenre(genreId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(genreName),
      ),
      body: Obx(
        () => GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: artistController.artists.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () async {
                final artistId = artistController.artists[index]['id'];
                final artistName = artistController.artists[index]['name'];
                final albums = await APIService.fetchAlbumsByArtist(artistId);
                Get.to(() => AlbumsPage(
                      artistId: artistId,
                      artistName: artistName,
                      albums: albums,
                    ));
              },
              child: Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        artistController.artists[index]['picture_medium'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(artistController.artists[index]['name']),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}