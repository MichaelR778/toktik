import 'package:toktik/features/like/domain/repositories/like_repository.dart';
import 'package:toktik/features/post/domain/entities/ui_post.dart';
import 'package:toktik/features/post/domain/repositories/post_repository.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/domain/repositories/profile_repository.dart';

class FetchUserPosts {
  final PostRepository _postRepository;
  final LikeRepository _likeRepository;
  final ProfileRepository _profileRepository;

  FetchUserPosts({
    required PostRepository postRepository,
    required LikeRepository likeRepository,
    required ProfileRepository profileRepository,
  }) : _postRepository = postRepository,
       _likeRepository = likeRepository,
       _profileRepository = profileRepository;

  Future<List<UiPost>> call(String userId) async {
    final List<UiPost> uiPosts = [];

    UserProfile profile = UserProfile(
      userId: 'userId',
      username: 'username',
      profileImageUrl: 'profileImageUrl',
      followers: [],
      following: [],
    );
    try {
      profile = await _profileRepository.getProfile(userId);
    } catch (_) {}

    final fetchedPosts = await _postRepository.fetchUserPosts(userId);
    for (final post in fetchedPosts) {
      int likeCount = 0;
      try {
        likeCount = await _likeRepository.getLikeCount(post.id);
      } catch (_) {}
      uiPosts.add(UiPost(post: post.copyWith(likeCount), profile: profile));
    }

    return uiPosts;
  }
}
