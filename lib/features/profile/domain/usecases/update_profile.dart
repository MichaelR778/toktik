import 'package:toktik/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfile {
  final ProfileRepository _profileRepository;

  UpdateProfile({required ProfileRepository profileRepository})
    : _profileRepository = profileRepository;

  Future<void> call(String userId, String? newUsername, String? imagePath) {
    if (newUsername == null && imagePath == null) throw 'Nothing to update';
    // TODO: upload image to storage to get imageUrl then update profile
    return _profileRepository.updateProfile(userId, newUsername, imagePath);
  }
}
