import 'package:toktik/features/comment/domain/entities/ui_comment.dart';
import 'package:toktik/features/comment/domain/repositories/comment_repository.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/domain/repositories/profile_repository.dart';

class FetchComment {
  final CommentRepository _commentRepository;
  final ProfileRepository _profileRepository;

  FetchComment({
    required CommentRepository commentRepository,
    required ProfileRepository profileRepository,
  }) : _commentRepository = commentRepository,
       _profileRepository = profileRepository;

  Future<List<UiComment>> call(int postId) async {
    final List<UiComment> uiComments = [];

    final fetchedComments = await _commentRepository.fetchComments(postId);
    for (final comment in fetchedComments) {
      UserProfile profile = UserProfile(
        userId: 'userId',
        username: 'username',
        profileImageUrl: 'profileImageUrl',
        followers: [],
        following: [],
      );
      try {
        profile = await _profileRepository.getProfile(comment.userId);
      } catch (_) {}
      uiComments.add(UiComment(comment: comment, profile: profile));
    }

    return uiComments;
  }
}
