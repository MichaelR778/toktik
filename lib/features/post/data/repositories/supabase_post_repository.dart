import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toktik/features/post/data/models/post_model.dart';
import 'package:toktik/features/post/domain/entities/post.dart';
import 'package:toktik/features/post/domain/repositories/post_repository.dart';

class SupabasePostRepository implements PostRepository {
  final SupabaseClient _supabase;

  SupabasePostRepository({required SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Future<void> createPost(Post newPost) async {
    try {
      await _supabase
          .from('posts')
          .insert(PostModel.fromEntity(newPost).toJson());
    } catch (e) {
      throw 'Failed to create post: ${e.toString()}';
    }
  }

  @override
  Future<List<Post>> fetchPosts() async {
    try {
      final res = await _supabase.from('posts').select();
      return res.map((json) => PostModel.fromJson(json)).toList();
    } catch (e) {
      throw 'Failed to fetch posts: ${e.toString()}';
    }
  }

  @override
  Future<List<Post>> fetchUserPosts(String userId) async {
    try {
      final res = await _supabase.from('posts').select().eq('user_id', userId);
      return res.map((json) => PostModel.fromJson(json)).toList();
    } catch (e) {
      throw 'Failed to fetch user posts: ${e.toString()}';
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    try {
      await _supabase.from('posts').delete().eq('id', postId);
    } catch (e) {
      throw 'Failed to delete post: ${e.toString()}';
    }
  }
}
