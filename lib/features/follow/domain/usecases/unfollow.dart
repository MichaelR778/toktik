import 'package:toktik/features/follow/domain/repositories/follow_repository.dart';

class Unfollow {
  final FollowRepository _followRepository;

  Unfollow({required FollowRepository followRepository})
    : _followRepository = followRepository;

  Future<void> call(String currUserId, String userId) async {
    await _followRepository.unfollow(currUserId, userId);
  }
}
