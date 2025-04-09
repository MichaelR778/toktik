import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:toktik/features/profile/presentation/cubits/profile_state.dart';
import 'package:toktik/features/profile/presentation/widgets/profile_tile.dart';

class FollowListPage extends StatefulWidget {
  final UserProfile profile;
  final int index;

  const FollowListPage({super.key, required this.profile, required this.index});

  @override
  State<FollowListPage> createState() => _FollowListPageState();
}

class _FollowListPageState extends State<FollowListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile(widget.profile.userId);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.index,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.profile.username),
          bottom: const TabBar(
            tabs: [Tab(text: 'Following'), Tab(text: 'Followers')],
          ),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            // loading
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            // loaded
            else if (state is ProfileLoaded) {
              final profile = state.userProfile;
              return TabBarView(
                children: [
                  ListView.builder(
                    itemCount: profile.following.length,
                    itemBuilder:
                        (context, index) =>
                            ProfileTile(userId: profile.following[index]),
                  ),
                  ListView.builder(
                    itemCount: profile.followers.length,
                    itemBuilder:
                        (context, index) =>
                            ProfileTile(userId: profile.followers[index]),
                  ),
                ],
              );
            }

            // error etc
            return const Center(child: Text('Failed to fetch data'));
          },
        ),
      ),
    );
  }
}
