import 'package:toktik/features/post/domain/entities/ui_post.dart';

abstract class FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<UiPost> uiPosts;

  FeedLoaded({required this.uiPosts});
}

class FeedError extends FeedState {
  final String message;

  FeedError({required this.message});
}
