import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toktik/features/profile/data/models/user_profile_model.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/domain/repositories/profile_repository.dart';

class SupabaseProfileRepository implements ProfileRepository {
  final SupabaseClient _supabase;

  SupabaseProfileRepository({required SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Future<UserProfile> getProfile(String userId) async {
    try {
      final res =
          await _supabase.from('users').select().eq('id', userId).single();
      return UserProfileModel.fromJson(res);
    } catch (e) {
      throw 'Failed to get profile: ${e.toString()}';
    }
  }

  @override
  Future<void> updateProfile(
    String userId,
    String? newUsername,
    String? newProfileImageUrl,
  ) async {
    try {
      final Map<String, dynamic> data = {};

      if (newUsername != null) {
        data['username'] = newUsername;
      }
      if (newProfileImageUrl != null) {
        data['pfp_url'] = newProfileImageUrl;
      }

      if (data.isEmpty) {
        return;
      }

      await _supabase.from('users').update(data).eq('id', userId);
    } catch (e) {
      throw 'Failed to update profile: ${e.toString()}';
    }
  }
}
