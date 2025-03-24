import 'dart:io';

abstract class StorageRepository {
  Future<String> uploadImage(File imageFile, {String? fileName});
  Future<String> uploadVideo(File videoFile);
}
