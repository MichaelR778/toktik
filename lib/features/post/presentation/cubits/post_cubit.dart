import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/post/domain/usecases/create_post.dart';
import 'package:toktik/features/post/presentation/cubits/post_state.dart';

class PostCubit extends Cubit<PostState> {
  final CreatePost _createPostUsecase;

  PostCubit({required CreatePost createPostUsecase})
    : _createPostUsecase = createPostUsecase,
      super(PostInitial());

  Future<void> createPost(String userId) async {
    try {
      await _createPostUsecase(userId);
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }
}
