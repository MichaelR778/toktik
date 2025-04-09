import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final File? imageFile;
  final String imageUrl;
  final double diameter;
  static const double profileImageWidth = 90;

  const ProfileImage({
    super.key,
    this.imageFile,
    required this.imageUrl,
    required this.diameter,
  });

  Widget _placeHolder(context, {double? size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return imageFile != null
        ? Image.file(
          imageFile!,
          fit: BoxFit.cover,
          errorBuilder:
              (context, error, stackTrace) =>
                  _placeHolder(context, size: diameter),
        )
        : Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return _placeHolder(context, size: diameter);
          },
          errorBuilder:
              (context, error, stackTrace) =>
                  _placeHolder(context, size: diameter),
        );
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty && imageFile == null) {
      return _placeHolder(context, size: diameter);
    }

    return SizedBox(
      width: diameter,
      height: diameter,
      child: ClipOval(child: _buildImage(context)),
    );
  }
}
