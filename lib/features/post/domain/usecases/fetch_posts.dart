import 'package:toktik/features/like/domain/repositories/like_repository.dart';
import 'package:toktik/features/post/domain/entities/post.dart';
import 'package:toktik/features/post/domain/repositories/post_repository.dart';

class FetchPosts {
  final PostRepository _postRepository;
  final LikeRepository _likeRepository;

  FetchPosts({
    required PostRepository postRepository,
    required LikeRepository likeRepository,
  }) : _postRepository = postRepository,
       _likeRepository = likeRepository;

  Future<List<Post>> call() async {
    final List<Post> posts = [];

    final fetchedPosts = await _postRepository.fetchPosts();
    for (final post in fetchedPosts) {
      int likeCount;
      try {
        likeCount = await _likeRepository.getLikeCount(post.id);
      } catch (_) {
        posts.add(post);
        continue;
      }
      posts.add(post.copyWith(likeCount));
    }

    return posts;
  }
}
