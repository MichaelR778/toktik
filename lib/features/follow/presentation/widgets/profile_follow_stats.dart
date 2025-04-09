import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/follow/presentation/cubits/follow_cubit.dart';
import 'package:toktik/features/follow/presentation/cubits/follow_state.dart';
import 'package:toktik/features/follow/presentation/pages/follow_list_page.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_cubit.dart';

class ProfileFollowStats extends StatefulWidget {
  final UserProfile profile;
  final bool selfProfile;

  const ProfileFollowStats({
    super.key,
    required this.profile,
    required this.selfProfile,
  });

  @override
  State<ProfileFollowStats> createState() => _ProfileFollowStatsState();
}

class _ProfileFollowStatsState extends State<ProfileFollowStats> {
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
    final profileCubit = context.read<ProfileCubit>();
    return BlocBuilder<FollowCubit, FollowState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BlocProvider.value(
                          value: profileCubit,
                          child: FollowListPage(
                            profile: widget.profile,
                            index: 0,
                          ),
                        ),
                  ),
                );
              },
              child: SizedBox(
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
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BlocProvider.value(
                          value: profileCubit,
                          child: FollowListPage(
                            profile: widget.profile,
                            index: 1,
                          ),
                        ),
                  ),
                );
              },
              child: SizedBox(
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
            ),
          ],
        );
      },
    );
  }
}
