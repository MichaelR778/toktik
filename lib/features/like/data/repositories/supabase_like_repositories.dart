import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toktik/features/like/domain/repositories/like_repository.dart';

class SupabaseLikeRepositories implements LikeRepository {
  final SupabaseClient _supabase;

  SupabaseLikeRepositories({required SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Future<void> likePost(String userId, int postId) async {
    try {
      final likes = await fetchLikes(postId);
      likes.add(userId);
      await _supabase.from('posts').update({'likes': likes}).eq('id', postId);
    } catch (e) {
      throw 'Failed to like post: $e';
    }
  }

  @override
  Future<void> unlikePost(String userId, int postId) async {
    try {
      final likes = await fetchLikes(postId);
      likes.remove(userId);
      await _supabase.from('posts').update({'likes': likes}).eq('id', postId);
    } catch (e) {
      throw 'Failed to unlike post: $e';
    }
  }

  @override
  Future<bool> isLiked(String userId, int postId) async {
    try {
      final likes = await fetchLikes(postId);
      return likes.contains(userId);
    } catch (e) {
      throw 'Failed to check like state: $e';
    }
  }

  Future<List<String>> fetchLikes(int postId) async {
    try {
      final res =
          await _supabase
              .from('posts')
              .select('likes')
              .eq('id', postId)
              .single();
      return (res['likes'] as List<dynamic>)
          .map((userId) => userId as String)
          .toList();
    } catch (e) {
      throw 'Failed to fetch post like: $e';
    }
  }
}
