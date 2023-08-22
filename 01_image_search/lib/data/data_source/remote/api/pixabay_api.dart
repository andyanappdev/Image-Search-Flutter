import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_search_app/data/data_source/remote/dto/pixabay_result_dto.dart';

class PixabayApi {
  final http.Client _client;

  PixabayApi({http.Client? client}) : _client = (client ?? http.Client());

  Future<PixabayResultDto> getImages(String query) async {
    final String pixabayApiKey = dotenv.get('PIXABAYAPIKEY');
    final url =
        'https://pixabay.com/api/?key=$pixabayApiKey&q=$query&image_type=photo';
    final http.Response response = await _client.get(Uri.parse(url));

    Map<String, dynamic> jsonString = jsonDecode(response.body);
    return PixabayResultDto.fromJson(jsonString);
  }
}
