import 'package:flutter/material.dart';
import 'package:image_search_app/domain/model/photo.dart';
import 'package:image_search_app/presentation/detail/components/photo_detail_text.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatelessWidget {
  final Photo photo;

  const DetailScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "${photo.owner}'s Photo",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildOwnerInfo(),
          const SizedBox(height: 5),
          buildPhoto(),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Divider(thickness: 1.0),
          ),
          buildPhotoDetail(),
        ],
      ),
    );
  }

  Widget buildOwnerInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              photo.ownerImageURL,
              width: 40,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            photo.owner,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildPhoto() {
    return Hero(
      tag: photo.pageUrl,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.network(
            photo.webformatURL,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildPhotoDetail() {
    final NumberFormat formatter = NumberFormat('#,###');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Photo's Detail",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          PhotoDetailText(
            mainText: 'Total Views',
            subText: formatter.format(int.tryParse(photo.views.toString())),
          ),
          const SizedBox(height: 10),
          PhotoDetailText(
            mainText: 'Total Likes',
            subText: formatter.format(int.tryParse(photo.likes.toString())),
          ),
          const SizedBox(height: 10),
          PhotoDetailText(
            mainText: 'Tags',
            subText: photo.tags.toString(),
          ),
        ],
      ),
    );
  }
}
