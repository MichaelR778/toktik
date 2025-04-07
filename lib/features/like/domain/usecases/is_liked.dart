import 'package:toktik/features/like/domain/repositories/like_repository.dart';

class IsLiked {
  final LikeRepository _likeRepository;

  IsLiked({required LikeRepository likeRepository})
    : _likeRepository = likeRepository;

  Future<bool> call(String userId, int postId) =>
      _likeRepository.isLiked(userId, postId);
}
