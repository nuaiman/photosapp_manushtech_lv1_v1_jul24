import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

abstract class IPhotosApi {
  Future<String> fetchPhotos();
}
// -----------------------------------------------------------------------------

class PhotosApi implements IPhotosApi {
  @override
  Future<String> fetchPhotos() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/photos');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load albums');
    }
  }
}
// -----------------------------------------------------------------------------

final photosApiProvider = Provider<PhotosApi>((ref) {
  return PhotosApi();
});
