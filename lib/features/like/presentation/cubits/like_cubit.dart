import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/like/domain/usecases/toggle_like.dart';
import 'package:toktik/features/like/presentation/cubits/like_state.dart';
import 'package:toktik/features/post/domain/entities/post.dart';

// edited
class LikeCubit extends Cubit<LikeState> {
  final ToggleLike _toggleLikeUsecase;

  LikeCubit({required ToggleLike toggleLikeUsecase})
    : _toggleLikeUsecase = toggleLikeUsecase,
      super(LikeState(likedVideos: {}, initialLikeCounts: {}));
  bool _inProcess = false;

  void track(String userId, Post post) {
    final likesMap = Map<int, bool>.from(state.likedVideos);
    final countsMap = Map<int, int>.from(state.initialLikeCounts);

    likesMap[post.id] = post.likes.contains(userId);
    countsMap[post.id] = post.likes.length;

    emit(state.copyWith(likedVideos: likesMap, initialLikeCounts: countsMap));
  }

  Future<void> toggleLike(String userId, int postId) async {
    if (_inProcess) return;
    _inProcess = true;

    // positive update
    final currentLikes = Map<int, bool>.from(state.likedVideos);
    currentLikes[postId] = !(currentLikes[postId] ?? false);
    emit(state.copyWith(likedVideos: currentLikes));

    try {
      await _toggleLikeUsecase(userId, postId);
    } catch (e) {
      // revert update
      currentLikes[postId] = !(currentLikes[postId] ?? false);
      emit(state.copyWith(likedVideos: currentLikes));
    } finally {
      _inProcess = false;
    }
  }
}
