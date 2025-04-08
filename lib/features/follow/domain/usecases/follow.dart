import 'package:toktik/features/follow/domain/repositories/follow_repository.dart';

class Follow {
  final FollowRepository _followRepository;

  Follow({required FollowRepository followRepository})
    : _followRepository = followRepository;

  Future<void> call(String currUserId, String userId) async {
    await _followRepository.follow(currUserId, userId);
  }
}
