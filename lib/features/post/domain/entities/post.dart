class Post {
  final int id;
  final String userId;
  final String videoUrl;
  final int likes;

  Post({
    required this.id,
    required this.userId,
    required this.videoUrl,
    required this.likes,
  });

  Post copyWith(int newLikes) {
    return Post(id: id, userId: userId, videoUrl: videoUrl, likes: newLikes);
  }
}
