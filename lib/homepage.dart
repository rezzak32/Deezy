import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'artistspage.dart';
import 'controller.dart';

class HomePage extends StatelessWidget {
  final genreController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deezy'),
      ),
      body: Obx(
        () => GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: genreController.genres.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => Get.to(() => ArtistPage(
                genreId: genreController.genres[index]['id'],
                genreName: genreController.genres[index]['name'],
              )),
              child: Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        genreController.genres[index]['picture_medium'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(genreController.genres[index]['name']),
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