import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.article,
        color: Colors.grey,
        size: 60,
      ),
    );
  }
}
