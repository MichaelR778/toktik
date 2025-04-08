import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/auth/domain/usecases/get_current_user.dart';
import 'package:toktik/features/follow/domain/usecases/follow.dart';
import 'package:toktik/features/follow/domain/usecases/unfollow.dart';
import 'package:toktik/features/follow/presentation/cubits/follow_state.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';

class FollowCubit extends Cubit<FollowState> {
  final Follow _followUsecase;
  final Unfollow _unfollowUsecase;
  final GetCurrentUser _getCurrentUserUsecase;

  FollowCubit({
    required Follow followUsecase,
    required Unfollow unfollowUsecase,
    required GetCurrentUser getCurrentUserUsecase,
  }) : _followUsecase = followUsecase,
       _unfollowUsecase = unfollowUsecase,
       _getCurrentUserUsecase = getCurrentUserUsecase,
       super(
         FollowState(
           following: {},
           initialFollowersCount: {},
           currUserFollowingCount: 0,
         ),
       );

  void initCurrUserFollowingCount(int count) {
    emit(state.copyWith(currUserFollowingCount: count));
  }

  void track(UserProfile profile) {
    final followingMap = Map<String, bool>.from(state.following);
    final countsMap = Map<String, int>.from(state.initialFollowersCount);

    final currUser = _getCurrentUserUsecase();
    final isFollowing = profile.followers.contains(currUser.id);
    followingMap[profile.userId] = isFollowing;
    countsMap[profile.userId] =
        profile.followers.length - (isFollowing ? 1 : 0);

    emit(
      state.copyWith(following: followingMap, initialFollowersCount: countsMap),
    );
  }

  Future<void> follow(String userId) async {
    // ui state update
    final followingMap = Map<String, bool>.from(state.following);
    followingMap[userId] = true;
    emit(
      state.copyWith(
        following: followingMap,
        currUserFollowingCount: state.currUserFollowingCount + 1,
      ),
    );

    try {
      final currUser = _getCurrentUserUsecase();
      await _followUsecase.call(currUser.id, userId);
    } catch (_) {}
  }

  Future<void> unfollow(String userId) async {
    // ui state update
    final followingMap = Map<String, bool>.from(state.following);
    followingMap[userId] = false;
    emit(
      state.copyWith(
        following: followingMap,
        currUserFollowingCount: state.currUserFollowingCount - 1,
      ),
    );

    try {
      final currUser = _getCurrentUserUsecase();
      await _unfollowUsecase.call(currUser.id, userId);
    } catch (_) {}
  }
}
