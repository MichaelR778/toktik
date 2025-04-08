import 'package:toktik/features/like/domain/repositories/like_repository.dart';
import 'package:toktik/features/post/domain/entities/ui_post.dart';
import 'package:toktik/features/post/domain/repositories/post_repository.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/domain/repositories/profile_repository.dart';

class FetchPosts {
  final PostRepository _postRepository;
  final LikeRepository _likeRepository;
  final ProfileRepository _profileRepository;

  FetchPosts({
    required PostRepository postRepository,
    required LikeRepository likeRepository,
    required ProfileRepository profileRepository,
  }) : _postRepository = postRepository,
       _likeRepository = likeRepository,
       _profileRepository = profileRepository;

  Future<List<UiPost>> call() async {
    final List<UiPost> uiPosts = [];

    final fetchedPosts = await _postRepository.fetchPosts();
    for (final post in fetchedPosts) {
      int likeCount = 0;
      UserProfile profile = UserProfile(
        userId: 'userId',
        username: 'username',
        profileImageUrl: 'profileImageUrl',
        followers: [],
        following: [],
      );
      try {
        likeCount = await _likeRepository.getLikeCount(post.id);
        profile = await _profileRepository.getProfile(post.userId);
      } catch (_) {}
      uiPosts.add(UiPost(post: post.copyWith(likeCount), profile: profile));
    }

    return uiPosts;
  }
}
