import 'dart:convert';

import 'package:image_search_app/data/data_source/remote/dto/pixabay_result_dto.dart';
import 'package:image_search_app/data/mapper/photo_mapper.dart';
import 'package:image_search_app/domain/model/photo.dart';
import 'package:image_search_app/domain/repository/api_repository.dart';
import 'package:image_search_app/domain/repository/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final ApiRepository _api;

  PhotoRepositoryImpl(this._api);

  @override
  Future<List<Photo>> getPhotos(String query) async {
    try {
      final response = await _api.getImages(query);
      final resultDto = PixabayResultDto.fromJson(jsonDecode(response.body));

      if (resultDto.hits == null) {
        return [];
      }

      return resultDto.hits!.map((e) => e.toPhoto()).toList();
    } catch (e) {
      throw Exception('Error: API error 발생');
    }
  }
}
