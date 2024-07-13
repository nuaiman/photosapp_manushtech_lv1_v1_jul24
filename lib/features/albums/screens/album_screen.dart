import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/features/albums/widgets/album_widget.dart';

import '../notifiers/albums_notifier.dart';

class AlbumScreen extends ConsumerWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albums = ref.watch(albumsProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Albums'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: TextField(
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus!.unfocus(),
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ),
      body: albums.isNotEmpty
          ? ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return AlbumWidget(
                  album: album,
                );
              },
            )
          : const Center(
              child: Icon(Icons.hourglass_empty),
            ),
    );
  }
}
