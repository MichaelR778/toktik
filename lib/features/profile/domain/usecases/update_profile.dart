import 'dart:io';

import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/domain/repositories/profile_repository.dart';
import 'package:toktik/features/storage/domain/repositories/storage_repository.dart';

class UpdateProfile {
  final ProfileRepository _profileRepository;
  final StorageRepository _storageRepository;

  UpdateProfile({
    required ProfileRepository profileRepository,
    required StorageRepository storageRepository,
  }) : _profileRepository = profileRepository,
       _storageRepository = storageRepository;

  Future<void> call(
    UserProfile oldProfile,
    String newUsername,
    File? newProfileImage,
  ) async {
    // nothing to update
    if (newUsername == oldProfile.username && newProfileImage == null) {
      throw 'Nothing to update';
    }

    // empty username
    if (newUsername.isEmpty) throw 'New username can\'t be empty';

    // upload image
    String? newProfileImageUrl;
    if (newProfileImage != null) {
      newProfileImageUrl = await _storageRepository.uploadImage(
        newProfileImage,
      );
    }

    return _profileRepository.updateProfile(
      oldProfile.userId,
      newUsername == oldProfile.username ? null : newUsername,
      newProfileImageUrl,
    );
  }
}
