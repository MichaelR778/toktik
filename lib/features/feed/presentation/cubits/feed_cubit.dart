import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/feed/presentation/cubits/feed_state.dart';
import 'package:toktik/features/post/domain/entities/post.dart';
import 'package:toktik/features/post/domain/usecases/fetch_posts.dart';

class FeedCubit extends Cubit<FeedState> {
  final FetchPosts _fetchPostsUsecase;

  FeedCubit({required FetchPosts fetchPostsUsecase})
    : _fetchPostsUsecase = fetchPostsUsecase,
      super(FeedLoading());

  Future<void> fetchPosts() async {
    try {
      List<Post> posts = [];
      if (state is FeedLoaded) {
        final currPosts = (state as FeedLoaded).posts;
        posts.addAll(currPosts);
      }
      final newPosts = await _fetchPostsUsecase();
      posts.addAll(newPosts);
      emit(FeedLoaded(posts: posts));
    } catch (e) {
      emit(FeedError(message: e.toString()));
    }
  }
}
