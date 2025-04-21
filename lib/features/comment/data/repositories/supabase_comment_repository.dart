import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toktik/features/comment/data/models/comment_model.dart';
import 'package:toktik/features/comment/domain/entities/comment.dart';
import 'package:toktik/features/comment/domain/repositories/comment_repository.dart';

class SupabaseCommentRepository implements CommentRepository {
  final SupabaseClient _supabase;

  SupabaseCommentRepository({required SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Future<void> addComment(int postId, String content) async {
    try {
      final currentUserId = _supabase.auth.currentUser!.id;
      await _supabase.from('post_comments').insert({
        'post_id': postId,
        'user_id': currentUserId,
        'content': content,
      });
    } catch (e) {
      throw 'Failed to add comment: $e';
    }
  }

  @override
  Future<List<Comment>> fetchComments(int postId) async {
    try {
      final commentJsons = await _supabase
          .from('post_comments')
          .select()
          .eq('post_id', postId);
      return commentJsons
          .map((commentJson) => CommentModel.fromJson(commentJson))
          .toList();
    } catch (e) {
      throw 'Failed to fetch comments: $e';
    }
  }
}
