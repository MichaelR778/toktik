abstract class LikeRepository {
  Future<void> likePost(String userId, int postId);
  Future<void> unlikePost(String userId, int postId);
  Future<bool> isLiked(String userId, int postId);
}
