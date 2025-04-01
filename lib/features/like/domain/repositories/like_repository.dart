abstract class LikeRepository {
  Future<void> likePost(int postId);
  Future<void> unlikePost(int postId);
  Future<bool> isLiked(String userId, int postId);
}
