import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreviewWidget extends StatelessWidget {
  final String imagePath;

  const ImagePreviewWidget({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imagePath.isNotEmpty
                          ? FileImage(File(imagePath))
                          : const AssetImage(
                                  'assets/images/no_preview_available.png')
                              as ImageProvider,
                      fit: BoxFit.contain),
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.preview_rounded),
    );
  }
}
