import 'package:toktik/features/post/domain/entities/post.dart';

abstract class ProfilePostsState {}

class ProfilePostsLoading extends ProfilePostsState {}

class ProfilePostsLoaded extends ProfilePostsState {
  final List<Post> posts;

  ProfilePostsLoaded({required this.posts});
}

class ProfilePostsError extends ProfilePostsState {
  final String message;

  ProfilePostsError({required this.message});
}
