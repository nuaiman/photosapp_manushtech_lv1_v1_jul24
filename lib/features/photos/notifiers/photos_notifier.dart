import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/apis/photos_api.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/models/photo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotosNotifier extends StateNotifier<List<Photo>> {
  final PhotosApi _photosApi;
  PhotosNotifier({required PhotosApi photosApi})
      : _photosApi = photosApi,
        super([]);

  Future<void> fetchAndSetPhotos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final photosJson = prefs.getString('photos');

    List<Photo> photos;

    if (photosJson != null) {
      // If data is available in SharedPreferences, parse it directly
      List<dynamic> decoded = json.decode(photosJson);
      photos = decoded.map((photo) => Photo.fromJson(photo)).toList();
    } else {
      // Fetch from API if data is not available in SharedPreferences
      final response = await _photosApi.fetchPhotos();
      List<dynamic> decoded = json.decode(response);
      photos = decoded.map((photo) => Photo.fromJson(photo)).toList();

      // Save fetched data to SharedPreferences
      await prefs.setString('photos', response);
    }

    // Set state with fetched or cached photos
    state = photos;
  }

  List<Photo> getPhotosByAlbumId(int id) {
    return state
        .where(
          (element) => element.albumId == id,
        )
        .toList();
  }
}
// -----------------------------------------------------------------------------

final photosProvider =
    StateNotifierProvider<PhotosNotifier, List<Photo>>((ref) {
  final photosApi = ref.watch(photosApiProvider);
  return PhotosNotifier(photosApi: photosApi);
});
