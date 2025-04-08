class FollowState {
  final Map<String, bool> following;
  final Map<String, int> initialFollowersCount;
  final int currUserFollowingCount;

  FollowState({
    required this.following,
    required this.initialFollowersCount,
    required this.currUserFollowingCount,
  });

  FollowState copyWith({
    final Map<String, bool>? following,
    final Map<String, int>? initialFollowersCount,
    final int? currUserFollowingCount,
  }) {
    return FollowState(
      following: following ?? this.following,
      initialFollowersCount:
          initialFollowersCount ?? this.initialFollowersCount,
      currUserFollowingCount:
          currUserFollowingCount ?? this.currUserFollowingCount,
    );
  }

  int getDisplayFollowersCount(String userId) {
    final initialCount = initialFollowersCount[userId] ?? 0;
    final isFollowing = following[userId] ?? false;

    return initialCount + (isFollowing ? 1 : 0);
  }
}
