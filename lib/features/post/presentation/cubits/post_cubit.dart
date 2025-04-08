import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/auth/domain/usecases/get_current_user.dart';
import 'package:toktik/features/post/domain/usecases/create_post.dart';
import 'package:toktik/features/post/presentation/cubits/post_state.dart';

class PostCubit extends Cubit<PostState> {
  final CreatePost _createPostUsecase;
  final GetCurrentUser _getCurrentUserUsecase;

  PostCubit({
    required CreatePost createPostUsecase,
    required GetCurrentUser getCurrentUserUsecase,
  }) : _createPostUsecase = createPostUsecase,
       _getCurrentUserUsecase = getCurrentUserUsecase,
       super(PostInitial());

  Future<void> createPost() async {
    try {
      final currUser = _getCurrentUserUsecase();
      await _createPostUsecase(currUser.id);
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }
}
