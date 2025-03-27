import 'package:toktik/core/utils/file_util.dart';
import 'package:toktik/features/post/domain/entities/post.dart';
import 'package:toktik/features/post/domain/repositories/post_repository.dart';
import 'package:toktik/features/storage/domain/repositories/storage_repository.dart';

class CreatePost {
  final PostRepository _postRepository;
  final StorageRepository _storageRepository;

  CreatePost({
    required PostRepository postRepository,
    required StorageRepository storageRepository,
  }) : _postRepository = postRepository,
       _storageRepository = storageRepository;

  Future<void> call(String userId) async {
    final videoFile = await pickVideo();
    if (videoFile == null) return;

    final videoUrl = await _storageRepository.uploadVideo(videoFile);
    final newPost = Post(id: 'id', userId: userId, videoUrl: videoUrl);
    await _postRepository.createPost(newPost);
  }
}
