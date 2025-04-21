import 'package:toktik/features/comment/domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    required super.postId,
    required super.userId,
    required super.content,
    required super.timeAdded,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      postId: json['post_id'],
      userId: json['user_id'],
      content: json['content'],
      timeAdded: DateTime.parse(json['created_at']),
    );
  }
}
