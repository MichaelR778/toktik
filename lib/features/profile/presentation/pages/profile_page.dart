import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/dependency_injection.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_state.dart';

class ProfilePage extends StatelessWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..loadProfile(userId),
      child: _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final profile = state.userProfile;
          return Scaffold(
            appBar: AppBar(title: Text(profile.username)),
            body: Column(
              children: [
                // profile picture
                CircleAvatar(
                  foregroundImage: NetworkImage(profile.profileImageUrl),
                  radius: 40,
                ),

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

                const SizedBox(height: 10),
              ],
            ),
          );
        }

        return const Center(child: Text('Failed to load profile'));
      },
    );
  }
}
