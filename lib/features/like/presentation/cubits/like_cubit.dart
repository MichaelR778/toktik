import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/like/domain/usecases/is_liked.dart';
import 'package:toktik/features/like/domain/usecases/toggle_like.dart';
import 'package:toktik/features/like/presentation/cubits/like_state.dart';
import 'package:toktik/features/post/domain/entities/post.dart';

// edited
class LikeCubit extends Cubit<LikeState> {
  final ToggleLike _toggleLikeUsecase;
  final IsLiked _isLikedUsecase;

  LikeCubit({
    required ToggleLike toggleLikeUsecase,
    required IsLiked isLikedUsecase,
  }) : _toggleLikeUsecase = toggleLikeUsecase,
       _isLikedUsecase = isLikedUsecase,
       super(LikeState(likedVideos: {}, initialLikeCounts: {}));
  bool _inProcess = false;

  void track(String userId, Post post) async {
    final likesMap = Map<int, bool>.from(state.likedVideos);
    final countsMap = Map<int, int>.from(state.initialLikeCounts);

    likesMap[post.id] = await _isLikedUsecase(userId, post.id);
    countsMap[post.id] = post.likes;

    emit(state.copyWith(likedVideos: likesMap, initialLikeCounts: countsMap));
  }

  Future<void> toggleLike(String userId, int postId) async {
    if (_inProcess) return;
    _inProcess = true;

    final currentLikes = Map<int, bool>.from(state.likedVideos);
    final isLiked = currentLikes[postId] ?? false;
    // positive update for ui
    currentLikes[postId] = !isLiked;
    emit(state.copyWith(likedVideos: currentLikes));

    try {
      await _toggleLikeUsecase(userId, postId);
    } catch (e) {
      // revert positive update
      currentLikes[postId] = isLiked;
      emit(state.copyWith(likedVideos: currentLikes));
    } finally {
      _inProcess = false;
    }
  }
}
