import 'package:flutter/material.dart';
import 'package:toktik/features/post/domain/entities/post.dart';
import 'package:toktik/features/post/presentation/widgets/video_widget.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/presentation/widgets/profile_image.dart';

class PostPage extends StatelessWidget {
  final Post post;
  final UserProfile profile;

  const PostPage({super.key, required this.post, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VideoWidget(videoUrl: post.videoUrl),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              // username, post desc
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.username,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // like button etc
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ProfileImage(imageUrl: profile.profileImageUrl, radius: 50),
                    IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.chat)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.bookmark)),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_outward),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
