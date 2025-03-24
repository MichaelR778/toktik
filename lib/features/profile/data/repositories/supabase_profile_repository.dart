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
  ) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
