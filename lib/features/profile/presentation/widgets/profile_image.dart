import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final File? imageFile;
  final String imageUrl;
  static const double profileImageWidth = 90;

  const ProfileImage({super.key, this.imageFile, required this.imageUrl});

  Widget _placeHolder(context) {
    return Container(
      width: profileImageWidth,
      height: profileImageWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty && imageFile == null) return _placeHolder(context);

    return ClipOval(
      child:
          imageFile != null
              ? Image.file(
                imageFile!,
                width: profileImageWidth,
                height: profileImageWidth,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => _placeHolder(context),
              )
              : Image.network(
                imageUrl,
                width: profileImageWidth,
                height: profileImageWidth,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return _placeHolder(context);
                },
                errorBuilder:
                    (context, error, stackTrace) => _placeHolder(context),
              ),
    );
  }
}
