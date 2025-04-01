import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toktik/features/like/domain/repositories/like_repository.dart';

class SupabaseLikeRepositories implements LikeRepository {
  final SupabaseClient _supabase;

  SupabaseLikeRepositories({required SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Future<void> likePost(int postId) {
    // TODO: implement likePost
    throw UnimplementedError();
  }

  @override
  Future<void> unlikePost(int postId) {
    // TODO: implement unlikePost
    throw UnimplementedError();
  }

  @override
  Future<bool> isLiked(String userId, int postId) {
    // TODO: implement isLiked
    throw UnimplementedError();
  }
}
