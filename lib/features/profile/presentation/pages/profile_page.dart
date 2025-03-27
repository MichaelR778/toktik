import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/core/widgets/my_filled_button.dart';
import 'package:toktik/dependency_injection.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_state.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_state.dart';
import 'package:toktik/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:toktik/features/profile/presentation/widgets/profile_image.dart';

class ProfilePage extends StatelessWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    bool selfProfile =
        userId == (context.read<AuthCubit>().state as Authenticated).user.id;
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..loadProfile(userId),
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            // loading
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            // loaded
            else if (state is ProfileLoaded) {
              final profile = state.userProfile;
              return RefreshIndicator(
                onRefresh:
                    () => context.read<ProfileCubit>().loadProfile(userId),
                child: SingleChildScrollView(
                  physics:
                      AlwaysScrollableScrollPhysics(), // might remove later after fully implementing profle page
                  child: Column(
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
                            child: Column(
                              children: [Text('0'), Text('Following')],
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Column(
                              children: [Text('0'), Text('Followers')],
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Column(children: [Text('0'), Text('Likes')]),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // edit profile button
                      if (selfProfile)
                        MyFilledTextButton(
                          text: 'Edit Profile',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        EditProfilePage(userId: userId),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
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
