import 'package:flutter/material.dart';

class PhotoDetailText extends StatelessWidget {
  final String mainText;
  final String subText;

  const PhotoDetailText({
    super.key,
    required this.mainText,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '$mainText : ',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        children: [
          TextSpan(
            text: subText,
            style:
                const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
