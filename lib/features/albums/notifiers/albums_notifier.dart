import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/apis/album_api.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/models/album.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlbumsNotifier extends StateNotifier<List<Album>> {
  final AlbumsApi _albumsApi;
  AlbumsNotifier({required AlbumsApi albumsApi})
      : _albumsApi = albumsApi,
        super([]);

  Future<void> fetchAndSetAlbums() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final albumsJson = prefs.getString('albums');

    List<Album> albums;

    if (albumsJson != null) {
      // If data is available in SharedPreferences, parse it directly
      List<dynamic> decoded = json.decode(albumsJson);
      albums = decoded.map((album) => Album.fromJson(album)).toList();
    } else {
      // Fetch from API if data is not available in SharedPreferences
      final response = await _albumsApi.fetchAlbums();
      List<dynamic> decoded = json.decode(response);
      albums = decoded.map((album) => Album.fromJson(album)).toList();

      // Save fetched data to SharedPreferences
      await prefs.setString('albums', response);
    }

    // Set state with fetched or cached albums
    state = albums;
  }
}
// -----------------------------------------------------------------------------

final albumsProvider =
    StateNotifierProvider<AlbumsNotifier, List<Album>>((ref) {
  final albumsApi = ref.watch(albumsApiProvider);
  return AlbumsNotifier(albumsApi: albumsApi);
});
