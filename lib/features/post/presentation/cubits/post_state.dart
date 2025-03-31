abstract class PostState {}

class PostInitial extends PostState {}

class PostUploading extends PostState {}

class PostUploaded extends PostState {}

class PostError extends PostState {
  final String message;

  PostError({required this.message});
}
