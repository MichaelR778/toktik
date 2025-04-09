import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/dependency_injection.dart';
import 'package:toktik/features/follow/presentation/widgets/follow_button.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_state.dart';
import 'package:toktik/features/profile/presentation/pages/profile_page.dart';
import 'package:toktik/features/profile/presentation/widgets/profile_image.dart';

class ProfileTile extends StatelessWidget {
  final String userId;

  const ProfileTile({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..loadProfile(userId),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            final profile = state.userProfile;
            return ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: ProfileImage(
                imageUrl: profile.profileImageUrl,
                diameter: 50,
              ),
              title: Text(profile.username),
              trailing: FollowButton(userId: userId),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(userId: userId),
                  ),
                );
              },
            );
          }
          return const ListTile(
            leading: CircularProgressIndicator(),
            title: Text('Loading...'),
          );
        },
      ),
    );
  }
}
