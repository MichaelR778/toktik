import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toktik/features/follow/domain/repositories/follow_repository.dart';

class SupabaseFollowRepository implements FollowRepository {
  final SupabaseClient _supabase;

  SupabaseFollowRepository({required SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Future<void> follow(String currUserId, String targetId) async {
    try {
      // add follower to target
      final targetFollowers = await getFollowers(targetId);
      targetFollowers.add(currUserId);
      await _supabase
          .from('users')
          .update({'followers': targetFollowers})
          .eq('id', targetId);

      // add following to curruser
      final following = await getFollowing(currUserId);
      following.add(targetId);
      await _supabase
          .from('users')
          .update({'following': following})
          .eq('id', currUserId);
    } catch (e) {
      throw 'Failed to follow: $e';
    }
  }

  @override
  Future<void> unfollow(String currUserId, String targetId) async {
    try {
      // remove follower to target
      final targetFollowers = await getFollowers(targetId);
      targetFollowers.remove(currUserId);
      await _supabase
          .from('users')
          .update({'followers': targetFollowers})
          .eq('id', targetId);

      // remove following to curruser
      final following = await getFollowing(currUserId);
      following.remove(targetId);
      await _supabase
          .from('users')
          .update({'following': following})
          .eq('id', currUserId);
    } catch (e) {
      throw 'Failed to unfollow: $e';
    }
  }

  @override
  Future<List<String>> getFollowers(String userId) async {
    try {
      final res =
          await _supabase
              .from('users')
              .select('followers')
              .eq('id', userId)
              .single();
      return (res['followers'] as List<dynamic>)
          .map((userId) => userId as String)
          .toList();
    } catch (e) {
      throw 'Failed to get followers: $e';
    }
  }

  @override
  Future<List<String>> getFollowing(String userId) async {
    try {
      final res =
          await _supabase
              .from('users')
              .select('following')
              .eq('id', userId)
              .single();
      return (res['following'] as List<dynamic>)
          .map((userId) => userId as String)
          .toList();
    } catch (e) {
      throw 'Failed to get following: $e';
    }
  }
}
