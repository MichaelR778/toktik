import 'package:toktik/features/post/domain/entities/post.dart';

abstract class PostRepository {
  Future<void> createPost(Post newPost);
  Future<List<Post>> fetchPosts();
  Future<List<Post>> fetchUserPosts(String userId);
  Future<void> deletePost(String postId);
}
