import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/auth/domain/entities/user_entity.dart';
import 'package:toktik/features/like/domain/usecases/toggle_like.dart';
import 'package:toktik/features/post/domain/entities/post.dart';

class LikeCubit extends Cubit<bool> {
  final ToggleLike _toggleLikeUsecase;

  LikeCubit({required ToggleLike toggleLikeUsecase})
    : _toggleLikeUsecase = toggleLikeUsecase,
      super(false);
  bool _inProcess = false;

  void init(Post post, UserEntity currentUser) {
    final liked = post.likes.contains(currentUser.id);
    emit(liked);
  }

  Future<void> toggleLike(String userId, int postId) async {
    if (_inProcess) return;
    _inProcess = true;

    // positive update
    emit(!state);

    try {
      await _toggleLikeUsecase(userId, postId);
    } catch (e) {
      // revert update
      emit(!state);
      print(e.toString());
    } finally {
      _inProcess = false;
    }
  }
}
