import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/post/domain/usecases/fetch_user_posts.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_posts_state.dart';

class ProfilePostsCubit extends Cubit<ProfilePostsState> {
  final FetchUserPosts _fetchUserPostsUsecase;

  ProfilePostsCubit({required FetchUserPosts fetchUserPostsUsecase})
    : _fetchUserPostsUsecase = fetchUserPostsUsecase,
      super(ProfilePostsLoading());

  Future<void> fetchUserPosts(String userId) async {
    try {
      emit(ProfilePostsLoading());
      final posts = await _fetchUserPostsUsecase(userId);
      emit(ProfilePostsLoaded(posts: posts));
    } catch (e) {
      emit(ProfilePostsError(message: e.toString()));
    }
  }
}
