import 'dart:io';

import 'package:flutter/material.dart';

class PreviewImage extends StatelessWidget {
  final File image;
  PreviewImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(image, fit: BoxFit.cover),
        )
      ],
    );
  }
}
