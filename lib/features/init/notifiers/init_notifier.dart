import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/features/albums/notifiers/albums_notifier.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/features/albums/screens/album_screen.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/features/photos/notifiers/photos_notifier.dart';

import '../../../core/utils/navigators.dart';

class InitNotifier extends StateNotifier<bool> {
  final AlbumsNotifier _albums;
  final PhotosNotifier _photos;
  InitNotifier({required AlbumsNotifier albums, required PhotosNotifier photos})
      : _albums = albums,
        _photos = photos,
        super(false);

  Future<void> initializeAlbumsAndPhotos(BuildContext context) async {
    await Future.wait([
      _albums.fetchAndSetAlbums(),
      _photos.fetchAndSetPhotos(),
    ]);

    if (context.mounted) {
      navigateAndReplace(context, const AlbumScreen());
    }
  }
}
// -----------------------------------------------------------------------------

final initProvider = StateNotifierProvider<InitNotifier, bool>((ref) {
  final albums = ref.read(albumsProvider.notifier);
  final photos = ref.read(photosProvider.notifier);
  return InitNotifier(
    albums: albums,
    photos: photos,
  );
});
