abstract class FollowRepository {
  Future<void> follow(String currUserId, String targetId);
  Future<void> unfollow(String currUserId, String targetId);
  Future<List<String>> getFollowers(String userId);
  Future<List<String>> getFollowing(String userId);
}
