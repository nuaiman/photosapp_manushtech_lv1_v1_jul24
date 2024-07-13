import 'package:flutter/material.dart';

import '../../../models/album.dart';
import 'album_widget.dart';

class AlbumList extends StatelessWidget {
  final List<Album> albums;

  const AlbumList({required this.albums});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return AlbumWidget(
          album: album,
        );
      },
    );
  }
}
