import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/apis/photos_api.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/core/providers/loader_notifier.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/models/photo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotosNotifier extends StateNotifier<List<Photo>> {
  final PhotosApi _photosApi;
  final LoaderNotifier _loader;
  PhotosNotifier({
    required PhotosApi photosApi,
    required LoaderNotifier loader,
  })  : _photosApi = photosApi,
        _loader = loader,
        super([]);

  int _currentIndex = 1;

  void initIndex() {
    _currentIndex = 1;
  }

  void updateIndex() {
    if (_currentIndex == 2) {
      return;
    }
    _currentIndex++;
    state = [...state];
  }

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
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        _loader.updateState(false);
      },
    );

    final returnable = state
        .where(
          (element) => element.albumId == id,
        )
        .toList()
        .take(_currentIndex * 25)
        .toList();

    Future.delayed(
      const Duration(seconds: 1),
      () {
        _loader.updateState(true);
      },
    );

    return returnable;
  }
}
// -----------------------------------------------------------------------------

final photosProvider =
    StateNotifierProvider<PhotosNotifier, List<Photo>>((ref) {
  final photosApi = ref.watch(photosApiProvider);
  final loader = ref.watch(loaderProvider.notifier);
  return PhotosNotifier(
    photosApi: photosApi,
    loader: loader,
  );
});
