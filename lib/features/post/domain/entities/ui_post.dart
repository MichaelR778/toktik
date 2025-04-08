import 'package:toktik/features/post/domain/entities/post.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';

class UiPost {
  final Post post;
  final UserProfile profile;

  UiPost({required this.post, required this.profile});
}
