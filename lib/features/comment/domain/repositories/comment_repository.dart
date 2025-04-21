import 'package:toktik/features/comment/domain/entities/comment.dart';

abstract class CommentRepository {
  Future<void> addComment(int postId, String content);
  Future<List<Comment>> fetchComments(int postId);
}
