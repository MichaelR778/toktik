import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  // pick an image
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image == null) return null;

  // crop image
  final ImageCropper imageCropper = ImageCropper();
  final CroppedFile? cropped = await imageCropper.cropImage(
    sourcePath: image.path,
    aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
  );

  if (cropped == null) return null;

  return File(cropped.path);
}

Future<File?> pickVideo() async {
  final res = await FilePicker.platform.pickFiles(type: FileType.video);
  if (res == null) return null;

  final path = res.files.first.path;
  if (path == null) return null;

  return File(path);
}
