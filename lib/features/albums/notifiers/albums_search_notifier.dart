import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlbumsSearchNotifier extends StateNotifier<String> {
  AlbumsSearchNotifier() : super('');

  void updateState(String searchTerm) {
    state = searchTerm;
  }
}
// -----------------------------------------------------------------------------

final albumsSearchProvider =
    StateNotifierProvider<AlbumsSearchNotifier, String>((ref) {
  return AlbumsSearchNotifier();
});
