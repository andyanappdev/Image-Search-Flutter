import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/domain/model/photo.dart';
import 'package:image_search_app/domain/repository/photo_repository.dart';

class GetTopFiveMostViewedImagesUseCase {
  final PhotoRepository _repository;

  GetTopFiveMostViewedImagesUseCase(this._repository);

  Future<Result<List<Photo>>> execute(String query) async {
    try {
      final photos = await _repository.getPhotos(query);
      // views를 서로 비교해서 views가 높은 순서대로 정렬
      photos.sort((a, b) => -a.views.compareTo(b.views));
      // 정렬된 list에서 차례대로 5개만 꺼내서 return
      return Result.success(photos.take(5).toList());
    } catch (e) {
      return const Result.error('Error: Network Error 발생');
    }
  }
}
