import 'package:toktik/features/post/domain/entities/post.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';

abstract class FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<Post> posts;
  final List<UserProfile> profiles;

  FeedLoaded({required this.posts, required this.profiles});
}

class FeedError extends FeedState {
  final String message;

  FeedError({required this.message});
}
