import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/features/albums/notifiers/albums_search_notifier.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/features/albums/notifiers/filtered_albums_notifier.dart';

import '../widgets/album_app_bar.dart';
import '../widgets/album_list.dart';

class AlbumScreen extends ConsumerWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(albumsSearchProvider);
    final albums =
        ref.watch(filteredAlbumsProvider.notifier).getFilteredResult();
    return Scaffold(
      appBar: const AlbumAppBar(),
      body: albums.isNotEmpty
          ? AlbumList(albums: albums)
          : const Center(
              child: Icon(Icons.hourglass_empty),
            ),
    );
  }
}
