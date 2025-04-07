import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/feed/presentation/cubits/feed_cubit.dart';
import 'package:toktik/features/feed/presentation/cubits/feed_state.dart';
import 'package:toktik/features/post/presentation/widgets/post_view.dart';

// TODO: implement doomscroll
class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FeedCubit, FeedState>(
        builder: (context, state) {
          // loading
          if (state is FeedLoading) {
            return Center(child: CircularProgressIndicator());
          }
          // loaded
          else if (state is FeedLoaded) {
            final posts = state.posts;
            final profiles = state.profiles;
            return RefreshIndicator(
              onRefresh: () => context.read<FeedCubit>().init(),
              child: PostView(posts: posts, profiles: profiles),
            );
          }
          // error
          else if (state is FeedError) {
            return Center(child: Text(state.message));
          }

          // error etc
          return Center(child: const Text('Something went wrong'));
        },
      ),
    );
  }
}
