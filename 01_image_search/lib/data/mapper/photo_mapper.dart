import 'package:image_search_app/data/data_source/remote/dto/pixabay_result_dto.dart';
import 'package:image_search_app/domain/model/photo.dart';

extension ToPhoto on Hits {
  Photo toPhoto() {
    return Photo(
      id: id ?? 0,
      owner: user ?? '',
      pageUrl: pageURL ?? '',
      url: webformatURL ?? '',
      tags: tags ?? '',
      views: views ?? 0,
      likes: likes ?? 0,
    );
  }
}
