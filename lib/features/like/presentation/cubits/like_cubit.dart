import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/auth/domain/usecases/get_current_user.dart';
import 'package:toktik/features/like/domain/usecases/is_liked.dart';
import 'package:toktik/features/like/domain/usecases/toggle_like.dart';
import 'package:toktik/features/like/presentation/cubits/like_state.dart';
import 'package:toktik/features/post/domain/entities/post.dart';

// edited
class LikeCubit extends Cubit<LikeState> {
  final ToggleLike _toggleLikeUsecase;
  final IsLiked _isLikedUsecase;
  final GetCurrentUser _getCurrentUserUsecase;

  LikeCubit({
    required ToggleLike toggleLikeUsecase,
    required IsLiked isLikedUsecase,
    required GetCurrentUser getCurrentuserUsecase,
  }) : _toggleLikeUsecase = toggleLikeUsecase,
       _isLikedUsecase = isLikedUsecase,
       _getCurrentUserUsecase = getCurrentuserUsecase,
       super(LikeState(likedVideos: {}, initialLikeCounts: {}));

  bool _inProcess = false;

  void track(Post post) async {
    final likesMap = Map<int, bool>.from(state.likedVideos);
    final countsMap = Map<int, int>.from(state.initialLikeCounts);

    final currUser = _getCurrentUserUsecase();
    final isLiked = await _isLikedUsecase(currUser.id, post.id);
    likesMap[post.id] = isLiked;

    // like count without curr/user's like to make sure
    // like_state display like count work properly
    countsMap[post.id] = post.likes - (isLiked ? 1 : 0);

    emit(state.copyWith(likedVideos: likesMap, initialLikeCounts: countsMap));
  }

  Future<void> toggleLike(int postId) async {
    if (_inProcess) return;
    _inProcess = true;

    final currentLikes = Map<int, bool>.from(state.likedVideos);
    final isLiked = currentLikes[postId] ?? false;
    // positive update for ui
    currentLikes[postId] = !isLiked;
    emit(state.copyWith(likedVideos: currentLikes));

    try {
      final currUser = _getCurrentUserUsecase();
      await _toggleLikeUsecase(currUser.id, postId);
    } catch (e) {
      // revert positive update
      currentLikes[postId] = isLiked;
      emit(state.copyWith(likedVideos: currentLikes));
    } finally {
      await Future.delayed(const Duration(milliseconds: 300));
      _inProcess = false;
    }
  }
}
