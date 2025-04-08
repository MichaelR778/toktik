import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/core/widgets/my_filled_button.dart';
import 'package:toktik/features/follow/presentation/cubits/follow_cubit.dart';
import 'package:toktik/features/follow/presentation/cubits/follow_state.dart';

class FollowButton extends StatelessWidget {
  final String userId;

  const FollowButton({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowCubit, FollowState>(
      builder: (context, state) {
        final isFollowing = state.following[userId] ?? false;
        return MyFilledTextButton(
          text: isFollowing ? 'Unfollow' : 'Follow',
          onTap: () {
            if (isFollowing) {
              context.read<FollowCubit>().unfollow(userId);
            } else {
              context.read<FollowCubit>().follow(userId);
            }
          },
        );
      },
    );
  }
}
