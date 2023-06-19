import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:image_picker/image_picker.dart';

class ImagePicKPreviewWidget extends StatefulWidget {
  final bool forStudentImage;
  final bool forStudentIdImage;

  ImagePicKPreviewWidget({
    super.key,
    this.forStudentIdImage = false,
    this.forStudentImage = false,
  });

  @override
  State<ImagePicKPreviewWidget> createState() => _ImagePicKPreviewWidgetState();
}

class _ImagePicKPreviewWidgetState extends State<ImagePicKPreviewWidget> {
  final ImagePicker _imagePicker = ImagePicker();

  String studentImagePath = '';

  String studentIdImagePath = '';

  void pickImage(
      {required bool forStudentImage,
      required bool forStudentImageId,
      required isCamera}) async {
    final XFile? image = await _imagePicker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);

    if (image != null && forStudentImage) {
      setState(() {
        studentImagePath = image.path;
      });
    } else if (image != null && forStudentImageId) {
      setState(() {
        studentIdImagePath = image.path;
      });
    } else {
      dev.log('Image is null', name: 'ImagePicker');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            pickImage(
                forStudentImage: widget.forStudentImage,
                forStudentImageId: widget.forStudentIdImage,
                isCamera: true);
          },
          icon: const Icon(Icons.camera_alt_rounded),
        ),
        IconButton(
          onPressed: () {
            pickImage(
                forStudentImage: widget.forStudentImage,
                forStudentImageId: widget.forStudentIdImage,
                isCamera: false);
          },
          icon: const Icon(Icons.upload),
        ),
        IconButton(
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
                          image: studentImagePath.isNotEmpty
                              ? FileImage(File(studentImagePath))
                              : studentIdImagePath.isNotEmpty
                                  ? FileImage(File(studentIdImagePath))
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
        ),
      ],
    );
  }
}
