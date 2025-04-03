import 'package:flutter/material.dart';
import 'package:toktik/features/post/domain/entities/post.dart';
import 'package:toktik/features/post/presentation/widgets/post_view.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:video_player/video_player.dart';

class PostCard extends StatefulWidget {
  final String videoUrl;
  final List<Post> posts;
  final List<UserProfile> profiles;
  final int index;

  const PostCard({
    super.key,
    required this.videoUrl,
    required this.posts,
    required this.profiles,
    required this.index,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  body: PostView(
                    posts: widget.posts,
                    profiles: widget.profiles,
                    index: widget.index,
                  ),
                ),
          ),
        );
      },
      child: Container(
        color: Colors.black,
        child: Center(
          child:
              _controller.value.isInitialized
                  ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                  : null,
        ),
      ),
    );
  }
}
