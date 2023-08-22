import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_search_app/domain/repository/api_repository.dart';

class PixabayApi implements ApiRepository {
  final http.Client _client;

  PixabayApi({http.Client? client}) : _client = (client ?? http.Client());

  @override
  Future<http.Response> getImages(String query) async {
    return await _client.get(Uri.parse(
        'https://pixabay.com/api/?key=${dotenv.get('PIXABAYAPIKEY')}&q=$query&image_type=photo'));
  }
}
