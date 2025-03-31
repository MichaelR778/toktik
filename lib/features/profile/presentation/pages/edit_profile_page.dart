import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/core/utils/file_util.dart';
import 'package:toktik/core/widgets/my_filled_button.dart';
import 'package:toktik/dependency_injection.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_state.dart';
import 'package:toktik/features/profile/presentation/widgets/profile_image.dart';

class EditProfilePage extends StatelessWidget {
  final String userId;

  const EditProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..loadProfile(userId),
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit profile')),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            // loading
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            // loaded
            else if (state is ProfileLoaded) {
              return _ProfileLoadedWidget(profile: state.userProfile);
            }

            // error etc
            return const Center(child: Text('Failed to load profile'));
          },
        ),
      ),
    );
  }
}

class _ProfileLoadedWidget extends StatefulWidget {
  final UserProfile profile;

  const _ProfileLoadedWidget({required this.profile});

  @override
  State<_ProfileLoadedWidget> createState() => __ProfileLoadedWidgetState();
}

class __ProfileLoadedWidgetState extends State<_ProfileLoadedWidget> {
  final _controller = TextEditingController();
  File? newProfileImage;

  void _pickImage() async {
    final pickedImage = await pickImage();
    setState(() {
      newProfileImage = pickedImage;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // profile picture
          Stack(
            children: [
              // profile image
              ProfileImage(
                imageFile: newProfileImage,
                imageUrl: profile.profileImageUrl,
              ),
              // select image
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: ProfileImage.profileImageWidth,
                  height: ProfileImage.profileImageWidth,
                  decoration: BoxDecoration(
                    // color: Theme.of(
                    //   context,
                    // ).colorScheme.primary.withAlpha(100),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // username
          TextField(controller: _controller..text = profile.username),

          const SizedBox(height: 20),

          // save button
          MyFilledTextButton(
            text: 'Save',
            onTap: () {
              context.read<ProfileCubit>().updateProfile(
                profile,
                _controller.text,
                newProfileImage,
              );
              if (mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
