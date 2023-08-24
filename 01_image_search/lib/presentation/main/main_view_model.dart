import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/domain/use_case/get_top_five_most_viewed_images_use_case.dart';
import 'package:image_search_app/presentation/main/main_state.dart';
import 'package:image_search_app/presentation/main/main_ui_event.dart';

class MainViewModel with ChangeNotifier {
  final GetTopFiveMostViewedImagesUseCase _getTopFiveMostViewedImagesUseCase;

  MainState _state = const MainState();

  MainState get state => _state;

  final _eventController = StreamController<MainUiEvent>();

  Stream<MainUiEvent> get eventStream => _eventController.stream;

  MainViewModel(this._getTopFiveMostViewedImagesUseCase);

  // Timer? _debounce; //debounce용 타이머
  // void onEvent(MainEvent event) {
  //   switch (event) {
  //     case Refresh():
  //       _fetchImages();
  //     case SearchQueryChange(:final query):
  //       // query가 입력되고 300ms 이후에 실행되도록
  //       // (사용자 빠르게 타입하는 것을 모두 반영하지 않고 약간의 딜레이를 주기 위해)
  //       _debounce!.cancel();
  //       _debounce = Timer(const Duration(milliseconds: 300), () {
  //         _fetchImages(query: query);
  //       });
  //   }
  // }

  Future<void> fetchImages(String query) async {
    if (query.isEmpty) {
      _eventController.add(const ShowSnackBar('No Search Terms'));
      return;
    }

    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _getTopFiveMostViewedImagesUseCase.execute(query);

    switch (result) {
      case Success(:final data):
        _eventController.add(ShowSnackBar(
            '$query search results are sorted by number of views, with the top 5.'));
        _state = state.copyWith(isLoading: false, photos: data);
        notifyListeners();

      case Error(:final e):
        _eventController.add(ShowSnackBar(e));
    }
  }
}
