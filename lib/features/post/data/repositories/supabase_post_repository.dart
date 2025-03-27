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
  Future<List<Post>> fetchPosts() {
    // TODO: implement fetchPosts
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> fetchUserPosts(String userId) {
    // TODO: implement fetchUserPosts
    throw UnimplementedError();
  }

  @override
  Future<void> deletePost(String postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }
}
