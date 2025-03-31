import 'package:toktik/features/post/domain/entities/post.dart';
import 'package:toktik/features/post/domain/repositories/post_repository.dart';

class FetchUserPosts {
  final PostRepository _postRepository;

  FetchUserPosts({required PostRepository postRepository})
    : _postRepository = postRepository;

  Future<List<Post>> call(String userId) =>
      _postRepository.fetchUserPosts(userId);
}
