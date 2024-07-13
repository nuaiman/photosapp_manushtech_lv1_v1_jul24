import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/albums_notifier.dart';
import '../widgets/album_app_bar.dart';
import '../widgets/album_list.dart';

class AlbumScreen extends ConsumerWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albums = ref.watch(albumsProvider);
    return Scaffold(
      appBar: AlbumAppBar(),
      body: albums.isNotEmpty
          ? AlbumList(albums: albums)
          : const Center(
              child: Icon(Icons.hourglass_empty),
            ),
    );
  }
}
