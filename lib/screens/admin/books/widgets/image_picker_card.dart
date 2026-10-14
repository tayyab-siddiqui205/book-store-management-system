import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImagePickerCard extends StatelessWidget {
  final File? image;
  final Uint8List? webImage;
  final VoidCallback onPickImage;

  const ImagePickerCard({
    super.key,
    required this.image,
    required this.webImage,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (kIsWeb && webImage != null) {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.memory(
          webImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 220,
        ),
      );
    } else if (!kIsWeb && image != null) {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(
          image!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 220,
        ),
      );
    } else {
      imageWidget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [

          Icon(
            Icons.cloud_upload_rounded,
            size: 70,
            color: Color(0xff6C4EF6),
          ),

          SizedBox(height: 14),

          Text(
            "Upload Book Cover",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8),

          Text(
            "PNG, JPG or JPEG",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onPickImage,

      child: Container(
        width: double.infinity,
        height: 240,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),

        child: imageWidget,
      ),
    );
  }
}