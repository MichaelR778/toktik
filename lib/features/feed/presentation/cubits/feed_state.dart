import 'package:toktik/features/post/domain/entities/post.dart';

abstract class FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<Post> posts;

  FeedLoaded({required this.posts});
}

class FeedError extends FeedState {
  final String message;

  FeedError({required this.message});
}
