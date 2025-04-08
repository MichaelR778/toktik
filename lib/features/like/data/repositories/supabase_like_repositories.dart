import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toktik/features/like/domain/repositories/like_repository.dart';

class SupabaseLikeRepositories implements LikeRepository {
  final SupabaseClient _supabase;

  SupabaseLikeRepositories({required SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Future<void> likePost(String userId, int postId) async {
    try {
      await _supabase.from('post_likes').insert({
        'post_id': postId,
        'user_id': userId,
      });
    } catch (e) {
      throw 'Failed to like post: $e';
    }
  }

  @override
  Future<void> unlikePost(String userId, int postId) async {
    try {
      await _supabase.from('post_likes').delete().match({
        'post_id': postId,
        'user_id': userId,
      });
    } catch (e) {
      throw 'Failed to unlike post: $e';
    }
  }

  @override
  Future<bool> isLiked(String userId, int postId) async {
    try {
      final res =
          await _supabase
              .from('post_likes')
              .select()
              .eq('post_id', postId)
              .eq('user_id', userId)
              .maybeSingle();
      return res != null;
    } catch (e) {
      throw 'Failed to check like state: $e';
    }
  }

  @override
  Future<int> getLikeCount(int postId) async {
    try {
      final res =
          await _supabase
              .from('post_likes')
              .select()
              .eq('post_id', postId)
              .count();
      return res.count;
    } catch (e) {
      throw 'Failed to get post like count: $e';
    }
  }
}
