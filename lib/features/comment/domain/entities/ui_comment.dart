import 'package:toktik/features/comment/domain/entities/comment.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';

class UiComment {
  final Comment comment;
  final UserProfile profile;

  UiComment({required this.comment, required this.profile});
}
