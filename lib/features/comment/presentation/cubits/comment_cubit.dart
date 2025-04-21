import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/auth/domain/usecases/get_current_user.dart';
import 'package:toktik/features/comment/domain/entities/comment.dart';
import 'package:toktik/features/comment/domain/entities/ui_comment.dart';
import 'package:toktik/features/comment/domain/usecases/add_comment.dart';
import 'package:toktik/features/comment/domain/usecases/fetch_comment.dart';
import 'package:toktik/features/comment/presentation/cubits/comment_state.dart';
import 'package:toktik/features/profile/domain/usecases/get_profile.dart';

class CommentCubit extends Cubit<CommentState> {
  final AddComment _addCommentUsecase;
  final FetchComment _fetchCommentUsecase;
  final GetProfile _getProfileUsecase;
  final GetCurrentUser _getCurrentUserUsecase;

  CommentCubit({
    required AddComment addCommentUsecase,
    required FetchComment fetchCommentUsecase,
    required GetProfile getProfileUsecase,
    required GetCurrentUser getCurrentUserUsecase,
  }) : _addCommentUsecase = addCommentUsecase,
       _fetchCommentUsecase = fetchCommentUsecase,
       _getProfileUsecase = getProfileUsecase,
       _getCurrentUserUsecase = getCurrentUserUsecase,
       super(CommentLoading());

  Future<void> fetchComment(int postId) async {
    try {
      final uiComments = await _fetchCommentUsecase(postId);
      emit(CommentLoaded(uiComments: uiComments));
    } catch (e) {
      emit(CommentError(message: e.toString()));
    }
  }

  Future<void> addComment(int postId, String content) async {
    try {
      // positive ui update
      final currentUser = _getCurrentUserUsecase();
      final newComment = Comment(
        postId: postId,
        userId: currentUser.id,
        content: content,
        timeAdded: DateTime.now(),
      );
      final profile = await _getProfileUsecase(currentUser.id);
      final newUiComment = UiComment(comment: newComment, profile: profile);
      final oldUiComments = List<UiComment>.from(
        (state as CommentLoaded).uiComments,
      );
      oldUiComments.add(newUiComment);
      emit(CommentLoaded(uiComments: oldUiComments));

      try {
        await _addCommentUsecase(postId, content);
      } catch (e) {
        // revert ui update
        oldUiComments.remove(newUiComment);
        emit(CommentLoaded(uiComments: oldUiComments));
      }
    } catch (e) {
      // do nothing to not override the loaded comment with error state
    }
  }
}
