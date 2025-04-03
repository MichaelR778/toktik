import 'package:flutter/material.dart';
import 'package:toktik/features/post/domain/entities/post.dart';
import 'package:toktik/features/post/presentation/pages/post_page.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';

class PostView extends StatefulWidget {
  final List<Post> posts;
  final List<UserProfile> profiles;
  final int index;

  const PostView({
    super.key,
    required this.posts,
    required this.profiles,
    this.index = 0,
  });

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      scrollDirection: Axis.vertical,
      itemCount: widget.posts.length,
      itemBuilder: (context, index) {
        return PostPage(
          post: widget.posts[index],
          profile: widget.profiles[index],
        );
      },
    );
  }
}
