import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'photo.freezed.dart';

part 'photo.g.dart';

@freezed
class Photo with _$Photo {
  const factory Photo({
    required num id,
    required String owner,
    required String pageUrl,
    required String url,
    required String tags,
    required num views,
    required num likes,
  }) = _Photo;

  factory Photo.fromJson(Map<String, Object?> json) => _$PhotoFromJson(json);
}
