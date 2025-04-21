class Comment {
  final int postId;
  final String userId;
  final String content;
  final DateTime timeAdded;

  Comment({
    required this.postId,
    required this.userId,
    required this.content,
    required this.timeAdded,
  });
}
