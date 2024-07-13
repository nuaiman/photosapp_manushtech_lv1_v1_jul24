import 'package:flutter/material.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/features/photos/screens/photos_screen.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/models/album.dart';

class AlbumWidget extends StatelessWidget {
  final Album album;
  const AlbumWidget({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PhotosScreen(
              id: album.id,
            ),
          ));
        },
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 18,
          child: CircleAvatar(
            radius: 16,
            backgroundColor: Theme.of(context).cardColor,
            child: Text(album.id.toString()),
          ),
        ),
        title: Text(album.title),
      ),
    );
  }
}
