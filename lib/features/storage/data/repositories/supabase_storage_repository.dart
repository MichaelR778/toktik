import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toktik/features/storage/domain/repositories/storage_repository.dart';

class SupabaseStorageRepository implements StorageRepository {
  final SupabaseClient _supabase;

  SupabaseStorageRepository({required SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Future<String> uploadImage(File imageFile, {String? fileName}) async {
    try {
      final imageFileName =
          fileName ?? '${DateTime.now().microsecondsSinceEpoch}.png';
      await _supabase.storage.from('images').upload(imageFileName, imageFile);
      return _supabase.storage.from('images').getPublicUrl(imageFileName);
    } catch (e) {
      throw 'Failed to upload image: ${e.toString()}';
    }
  }

  @override
  Future<String> uploadVideo(File videoFile) async {
    try {
      final fileName = '${DateTime.now().microsecondsSinceEpoch}.mp4';
      await _supabase.storage.from('videos').upload(fileName, videoFile);
      return _supabase.storage.from('videos').getPublicUrl(fileName);
    } catch (e) {
      throw 'Failed to upload video: ${e.toString()}';
    }
  }
}
