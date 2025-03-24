import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/domain/repositories/profile_repository.dart';

class GetProfile {
  final ProfileRepository _profileRepository;

  GetProfile({required ProfileRepository profileRepository})
    : _profileRepository = profileRepository;

  Future<UserProfile> call(String userId) =>
      _profileRepository.getProfile(userId);
}
