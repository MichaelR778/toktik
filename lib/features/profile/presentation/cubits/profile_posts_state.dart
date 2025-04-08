import 'package:toktik/features/post/domain/entities/ui_post.dart';

abstract class ProfilePostsState {}

class ProfilePostsLoading extends ProfilePostsState {}

class ProfilePostsLoaded extends ProfilePostsState {
  final List<UiPost> uiPosts;

  ProfilePostsLoaded({required this.uiPosts});
}

class ProfilePostsError extends ProfilePostsState {
  final String message;

  ProfilePostsError({required this.message});
}
