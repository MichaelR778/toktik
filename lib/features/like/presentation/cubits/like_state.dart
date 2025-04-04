class LikeState {
  final Map<int, bool> likedVideos;
  final Map<int, int> initialLikeCounts;

  LikeState({required this.likedVideos, required this.initialLikeCounts});

  LikeState copyWith({
    Map<int, bool>? likedVideos,
    Map<int, int>? initialLikeCounts,
  }) {
    return LikeState(
      likedVideos: likedVideos ?? this.likedVideos,
      initialLikeCounts: initialLikeCounts ?? this.initialLikeCounts,
    );
  }

  int getDisplayLikeCount(int postId) {
    final initialCount = initialLikeCounts[postId] ?? 0;
    final userLiked = likedVideos[postId] ?? false;

    return initialCount + (userLiked ? 1 : 0);
  }
}
