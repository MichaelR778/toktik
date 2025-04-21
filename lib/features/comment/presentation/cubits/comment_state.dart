import 'package:toktik/features/comment/domain/entities/ui_comment.dart';

abstract class CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<UiComment> uiComments;

  CommentLoaded({required this.uiComments});
}

class CommentError extends CommentState {
  final String message;

  CommentError({required this.message});
}
