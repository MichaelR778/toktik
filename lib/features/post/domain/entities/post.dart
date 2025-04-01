class Post {
  final int id;
  final String userId;
  final String videoUrl;
  final List<String> likes;

  Post({
    required this.id,
    required this.userId,
    required this.videoUrl,
    required this.likes,
  });
}
