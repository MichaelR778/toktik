import 'package:toktik/features/like/domain/repositories/like_repository.dart';

class ToggleLike {
  final LikeRepository _likeRepository;

  ToggleLike({required LikeRepository likeRepository})
    : _likeRepository = likeRepository;

  Future<void> call(String userId, int postId) async {
    final isLiked = await _likeRepository.isLiked(userId, postId);
    if (isLiked) {
      await _likeRepository.unlikePost(postId);
    } else {
      await _likeRepository.likePost(postId);
    }
  }
}
