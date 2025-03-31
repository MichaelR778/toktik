import 'package:toktik/features/post/domain/entities/post.dart';
import 'package:toktik/features/post/domain/repositories/post_repository.dart';

class FetchPosts {
  final PostRepository _postRepository;

  FetchPosts({required PostRepository postRepository})
    : _postRepository = postRepository;

  Future<List<Post>> call() => _postRepository.fetchPosts();
}
