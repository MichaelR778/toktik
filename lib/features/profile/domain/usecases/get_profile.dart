import 'package:toktik/features/follow/domain/repositories/follow_repository.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/domain/repositories/profile_repository.dart';

class GetProfile {
  final ProfileRepository _profileRepository;
  final FollowRepository _followRepository;

  GetProfile({
    required ProfileRepository profileRepository,
    required FollowRepository followRepository,
  }) : _profileRepository = profileRepository,
       _followRepository = followRepository;

  Future<UserProfile> call(String userId) async {
    final profile = await _profileRepository.getProfile(userId);
    final followers = await _followRepository.getFollowers(userId);
    final following = await _followRepository.getFollowing(userId);
    return profile.copyWith(followers, following);
  }
}
