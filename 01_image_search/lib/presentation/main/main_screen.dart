import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/main/main_state.dart';
import 'package:image_search_app/presentation/main/main_ui_event.dart';
import 'package:image_search_app/presentation/main/main_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode textFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<MainViewModel>().eventStream.listen((event) {
        switch (event) {
          case ShowSnackBar(:final message):
            final snackBar = SnackBar(
              content: Text(
                message,
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black26,
              duration: const Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    textFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();
    final state = viewModel.state;
    return GestureDetector(
      onTap: () {
        textFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Image Search',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Column(
          children: [
            searchTextField(context, viewModel),
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final columnCount = switch (constraints.maxWidth) {
                    > 1150 => 4,
                    > 655 => 3,
                    _ => 2,
                  };

                  return photosGridView(columnCount, state);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchTextField(BuildContext context, MainViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        focusNode: textFocus,
        cursorColor: Theme.of(context).colorScheme.primary,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 2),
          ),
          labelText: 'Type Search Keywords',
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              viewModel.fetchImages(controller.text);
              controller.clear();
              textFocus.unfocus();
            },
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  Widget photosGridView(int columnCount, MainState state) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: state.photos.length,
      itemBuilder: (context, index) {
        final photo = state.photos[index];
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: InkWell(
            onTap: () {
              context.push('/detail', extra: photo);
            },
            child: Hero(
              tag: photo.pageUrl,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 4.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(photo.webformatURL, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
