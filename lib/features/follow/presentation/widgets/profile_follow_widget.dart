import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/follow/presentation/cubits/follow_cubit.dart';
import 'package:toktik/features/follow/presentation/cubits/follow_state.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';

class ProfileFollowWidget extends StatefulWidget {
  final UserProfile profile;
  final bool selfProfile;

  const ProfileFollowWidget({
    super.key,
    required this.profile,
    required this.selfProfile,
  });

  @override
  State<ProfileFollowWidget> createState() => _ProfileFollowWidgetState();
}

class _ProfileFollowWidgetState extends State<ProfileFollowWidget> {
  @override
  void initState() {
    super.initState();
    context.read<FollowCubit>().track(widget.profile);
    if (widget.selfProfile) {
      context.read<FollowCubit>().initCurrUserFollowingCount(
        widget.profile.following.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowCubit, FollowState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  Text(
                    widget.selfProfile
                        ? '${state.currUserFollowingCount}'
                        : '${widget.profile.following.length}',
                  ),
                  Text('Following'),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  Text(
                    '${state.getDisplayFollowersCount(widget.profile.userId)}',
                  ),
                  Text('Followers'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
