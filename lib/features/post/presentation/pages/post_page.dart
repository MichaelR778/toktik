import 'package:flutter/material.dart';
import 'package:toktik/features/like/presentation/widgets/like_button.dart';
import 'package:toktik/features/post/domain/entities/post.dart';
import 'package:toktik/features/post/presentation/widgets/post_button.dart';
import 'package:toktik/features/post/presentation/widgets/video_widget.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/presentation/pages/profile_page.dart';
import 'package:toktik/features/profile/presentation/widgets/profile_image.dart';

class PostPage extends StatelessWidget {
  final Post post;
  final UserProfile profile;

  const PostPage({super.key, required this.post, required this.profile});

  void navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(userId: profile.userId),
      ),
    );
  }

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
                    GestureDetector(
                      onTap: () => navigateToProfile(context),
                      child: Text(
                        profile.username,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
                    GestureDetector(
                      onTap: () => navigateToProfile(context),
                      child: ProfileImage(
                        imageUrl: profile.profileImageUrl,
                        radius: 50,
                      ),
                    ),
                    const SizedBox(height: 5),
                    LikeButton(post: post),
                    PostButton(
                      onTap: () {},
                      icon: Icons.chat,
                      color: Colors.white,
                      count: 0,
                    ),
                    PostButton(
                      onTap: () {},
                      icon: Icons.bookmark,
                      color: Colors.white,
                      count: 0,
                    ),
                    PostButton(
                      onTap: () {},
                      icon: Icons.arrow_outward,
                      color: Colors.white,
                      count: 0,
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
