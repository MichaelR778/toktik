import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/feed/presentation/cubits/feed_state.dart';
import 'package:toktik/features/post/domain/entities/ui_post.dart';
import 'package:toktik/features/post/domain/usecases/fetch_posts.dart';

class FeedCubit extends Cubit<FeedState> {
  final FetchPosts _fetchPostsUsecase;

  FeedCubit({required FetchPosts fetchPostsUsecase})
    : _fetchPostsUsecase = fetchPostsUsecase,
      super(FeedLoading());

  Future<void> init() async {
    emit(FeedLoading());
    try {
      final posts = await _fetchPostsUsecase();
      emit(FeedLoaded(uiPosts: posts));
    } catch (e) {
      emit(FeedError(message: e.toString()));
    }
  }

  Future<void> fetchPosts() async {
    try {
      List<UiPost> uiPosts = [];

      // keep post and poster profile from prev state
      if (state is FeedLoaded) {
        final currPosts = (state as FeedLoaded).uiPosts;
        uiPosts.addAll(currPosts);
      }

      // fetch posts and profiles
      final newPosts = await _fetchPostsUsecase();
      uiPosts.addAll(newPosts);
      emit(FeedLoaded(uiPosts: uiPosts));
    } catch (e) {
      emit(FeedError(message: e.toString()));
    }
  }
}
