import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/features/albums/notifiers/albums_notifier.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/features/albums/notifiers/albums_search_notifier.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/models/album.dart';

class FilteredAlbumsNotifier extends StateNotifier<List<Album>> {
  final List<Album> _albums;
  final String _searchTerm;
  FilteredAlbumsNotifier({
    required List<Album> albums,
    required String searchTerm,
  })  : _albums = albums,
        _searchTerm = searchTerm,
        super([]);

  List<Album> getFilteredResult() {
    List<Album> filteredAlbums = _albums;

    if (_searchTerm.isNotEmpty) {
      filteredAlbums = filteredAlbums
          .where((album) => album.title.toLowerCase().contains(_searchTerm))
          .toList();
    } else {
      filteredAlbums = filteredAlbums;
    }

    return filteredAlbums;
  }
}
// -----------------------------------------------------------------------------

final filteredAlbumsProvider =
    StateNotifierProvider<FilteredAlbumsNotifier, List<Album>>((ref) {
  final albums = ref.read(albumsProvider);
  final searchTerm = ref.watch(albumsSearchProvider);
  return FilteredAlbumsNotifier(
    albums: albums,
    searchTerm: searchTerm,
  );
});
