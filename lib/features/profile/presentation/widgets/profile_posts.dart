import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/dependency_injection.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_posts_cubit.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_posts_state.dart';
import 'package:toktik/features/post/presentation/widgets/post_card.dart';

class ProfilePosts extends StatelessWidget {
  final UserProfile profile;

  const ProfilePosts({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              getIt<ProfilePostsCubit>()..fetchUserPosts(profile.userId),
      child: BlocBuilder<ProfilePostsCubit, ProfilePostsState>(
        builder: (context, state) {
          // loading
          if (state is ProfilePostsLoading) {
            return const CircularProgressIndicator();
          }
          // loaded
          else if (state is ProfilePostsLoaded) {
            final posts = state.posts;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3 / 4,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostCard(
                  videoUrl: posts[index].videoUrl,
                  posts: posts,
                  profiles: List.generate(posts.length, (_) => profile),
                  index: index,
                );
              },
            );
          }

          // error etc
          return Text('Failed to fetch user posts');
        },
      ),
    );
  }
}
