import 'package:flutter/material.dart';
import 'package:toktik/features/post/domain/entities/ui_post.dart';
import 'package:toktik/features/post/presentation/pages/post_page.dart';

class PostView extends StatefulWidget {
  final List<UiPost> uiPosts;
  final int index;

  const PostView({super.key, required this.uiPosts, this.index = 0});

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
      itemCount: widget.uiPosts.length,
      itemBuilder: (context, index) {
        return PostPage(
          post: widget.uiPosts[index].post,
          profile: widget.uiPosts[index].profile,
        );
      },
    );
  }
}
