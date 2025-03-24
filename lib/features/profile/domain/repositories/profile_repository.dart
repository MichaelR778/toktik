import 'package:toktik/features/profile/domain/entities/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> getProfile(String userId);
  Future<void> updateProfile(
    String userId,
    String? newUsername,
    String? newProfileImageUrl,
  );
}
