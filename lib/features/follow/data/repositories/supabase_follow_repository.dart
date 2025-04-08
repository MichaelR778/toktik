import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toktik/features/follow/domain/repositories/follow_repository.dart';

class SupabaseFollowRepository implements FollowRepository {
  final SupabaseClient _supabase;

  SupabaseFollowRepository({required SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Future<void> follow(String currUserId, String targetId) async {
    try {
      await _supabase.from('followers').insert({
        'user_id': targetId,
        'follower_id': currUserId,
      });
    } catch (e) {
      throw 'Failed to follow: $e';
    }
  }

  @override
  Future<void> unfollow(String currUserId, String targetId) async {
    try {
      await _supabase.from('followers').delete().match({
        'user_id': targetId,
        'follower_id': currUserId,
      });
    } catch (e) {
      throw 'Failed to follow: $e';
    }
  }

  @override
  Future<List<String>> getFollowers(String userId) async {
    try {
      final res = await _supabase
          .from('followers')
          .select()
          .eq('user_id', userId);
      return res.map((data) => data['follower_id'] as String).toList();
    } catch (e) {
      throw 'Failed to get followers: $e';
    }
  }

  @override
  Future<List<String>> getFollowing(String userId) async {
    try {
      final res = await _supabase
          .from('followers')
          .select()
          .eq('follower_id', userId);
      return res.map((data) => data['user_id'] as String).toList();
    } catch (e) {
      throw 'Failed to get following: $e';
    }
  }
}
