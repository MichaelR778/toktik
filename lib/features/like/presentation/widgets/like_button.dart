import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_state.dart';
import 'package:toktik/features/like/presentation/cubits/like_cubit.dart';
import 'package:toktik/features/like/presentation/cubits/like_state.dart';
import 'package:toktik/features/post/domain/entities/post.dart';
import 'package:toktik/features/post/presentation/widgets/post_button.dart';

// edited
class LikeButton extends StatelessWidget {
  final Post post;

  const LikeButton({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final currUser = (context.read<AuthCubit>().state as Authenticated).user;
    return BlocBuilder<LikeCubit, LikeState>(
      builder: (context, state) {
        final isLiked = state.likedVideos[post.id] ?? false;
        return PostButton(
          onTap:
              () => context.read<LikeCubit>().toggleLike(currUser.id, post.id),
          icon: Icons.favorite,
          color: isLiked ? Colors.red : Colors.white,
          count: state.getDisplayLikeCount(post.id),
        );
      },
    );
  }
}
