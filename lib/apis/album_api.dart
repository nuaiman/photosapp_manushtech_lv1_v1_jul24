import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

abstract class IAlbumsApi {
  Future<String> fetchAlbums();
}
// -----------------------------------------------------------------------------

class AlbumsApi implements IAlbumsApi {
  @override
  Future<String> fetchAlbums() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/albums');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load albums');
    }
  }
}
// -----------------------------------------------------------------------------

final albumsApiProvider = Provider<AlbumsApi>((ref) {
  return AlbumsApi();
});
