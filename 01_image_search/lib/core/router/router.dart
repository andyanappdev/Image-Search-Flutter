import 'package:go_router/go_router.dart';
import 'package:image_search_app/data/data_source/remote/api/pixabay_api.dart';
import 'package:image_search_app/data/repository/photo_repository_impl.dart';
import 'package:image_search_app/domain/model/photo.dart';
import 'package:image_search_app/domain/use_case/get_top_five_most_viewed_images_use_case.dart';
import 'package:image_search_app/presentation/detail/detail_screen.dart';
import 'package:image_search_app/presentation/main/main_screen.dart';
import 'package:image_search_app/presentation/main/main_view_model.dart';
import 'package:provider/provider.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/main',
  routes: [
    GoRoute(
      path: '/main',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => MainViewModel(GetTopFiveMostViewedImagesUseCase(
              PhotoRepositoryImpl(PixabayApi()))),
          child: const MainScreen(),
        );
      },
    ),
    GoRoute(
      path: 'detail',
      builder: (context, state) {
        final Photo photo = state.extra as Photo;
        return DetailScreen(photo: photo);
      },
    ),
  ],
);
