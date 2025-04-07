import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/feed/presentation/cubits/feed_state.dart';
import 'package:toktik/features/post/domain/entities/post.dart';
import 'package:toktik/features/post/domain/usecases/fetch_posts.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/domain/usecases/get_profile.dart';

class FeedCubit extends Cubit<FeedState> {
  final FetchPosts _fetchPostsUsecase;
  final GetProfile _getProfileUsecase;

  FeedCubit({
    required FetchPosts fetchPostsUsecase,
    required GetProfile getProfileUsecase,
  }) : _fetchPostsUsecase = fetchPostsUsecase,
       _getProfileUsecase = getProfileUsecase,
       super(FeedLoading());

  Future<void> init() async {
    emit(FeedLoading());
    try {
      final posts = await _fetchPostsUsecase();
      final List<UserProfile> profiles = [];
      for (final post in posts) {
        final profile = await _getProfileUsecase(post.userId);
        profiles.add(profile);
      }
      emit(FeedLoaded(posts: posts, profiles: profiles));
    } catch (e) {
      emit(FeedError(message: e.toString()));
    }
  }

  Future<void> fetchPosts() async {
    try {
      List<Post> posts = [];
      List<UserProfile> profiles = [];

      // keep post and poster profile from prev state
      if (state is FeedLoaded) {
        final currPosts = (state as FeedLoaded).posts;
        posts.addAll(currPosts);
        final currProfiles = (state as FeedLoaded).profiles;
        profiles.addAll(currProfiles);
      }

      // fetch posts and profiles
      final newPosts = await _fetchPostsUsecase();
      posts.addAll(newPosts);
      for (final post in newPosts) {
        final profile = await _getProfileUsecase(post.userId);
        profiles.add(profile);
      }
      emit(FeedLoaded(posts: posts, profiles: profiles));
    } catch (e) {
      emit(FeedError(message: e.toString()));
    }
  }
}
