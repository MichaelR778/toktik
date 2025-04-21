import 'package:toktik/features/comment/domain/repositories/comment_repository.dart';

class AddComment {
  final CommentRepository _commentRepository;

  AddComment({required CommentRepository commentRepository})
    : _commentRepository = commentRepository;

  Future<void> call(int postId, String content) async {
    if (content.isEmpty) return;
    await _commentRepository.addComment(postId, content);
  }
}
