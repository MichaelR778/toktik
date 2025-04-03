import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/core/widgets/my_filled_button.dart';
import 'package:toktik/dependency_injection.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_state.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_state.dart';
import 'package:toktik/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:toktik/features/profile/presentation/widgets/profile_image.dart';
import 'package:toktik/features/profile/presentation/widgets/profile_posts.dart';

class ProfilePage extends StatelessWidget {
  final String userId;
  final bool home;

  const ProfilePage({super.key, required this.userId, this.home = false});

  void openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              context.read<AuthCubit>().logout();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currUser = (context.read<AuthCubit>().state as Authenticated).user;
    final selfProfile = userId == currUser.id;
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..loadProfile(userId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions:
              (selfProfile && home)
                  ? [
                    IconButton(
                      onPressed: () => openMenu(context),
                      icon: Icon(Icons.menu),
                    ),
                  ]
                  : null,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            // loading
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            // loaded
            else if (state is ProfileLoaded) {
              return _ProfileLoadedWidget(
                profile: state.userProfile,
                selfProfile: selfProfile,
              );
            }

            // error etc
            return const Center(child: Text('Failed to load profile'));
          },
        ),
      ),
    );
  }
}

class _ProfileLoadedWidget extends StatelessWidget {
  final UserProfile profile;
  final bool selfProfile;

  const _ProfileLoadedWidget({
    required this.profile,
    required this.selfProfile,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<ProfileCubit>().loadProfile(profile.userId),
      child: ListView(
        children: [
          Column(
            children: [
              // profile picture
              ProfileImage(imageUrl: profile.profileImageUrl),

              const SizedBox(height: 10),

              // username
              Text(profile.username),

              const SizedBox(height: 10),

              // following, followers, likes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: Column(children: [Text('0'), Text('Following')]),
                  ),
                  SizedBox(
                    width: 100,
                    child: Column(children: [Text('0'), Text('Followers')]),
                  ),
                  SizedBox(
                    width: 100,
                    child: Column(children: [Text('0'), Text('Likes')]),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // edit profile button
              selfProfile
                  ? MyFilledTextButton(
                    text: 'Edit Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  EditProfilePage(userId: profile.userId),
                        ),
                      );
                    },
                  )
                  : MyFilledTextButton(text: 'Follow', onTap: () {}),

              const SizedBox(height: 20),
            ],
          ),
          ProfilePosts(profile: profile),
        ],
      ),
    );
  }
}
