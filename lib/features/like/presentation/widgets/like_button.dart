import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/auth/domain/entities/user_entity.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_state.dart';
import 'package:toktik/features/like/presentation/cubits/like_cubit.dart';
import 'package:toktik/features/like/presentation/cubits/like_state.dart';
import 'package:toktik/features/post/domain/entities/post.dart';
import 'package:toktik/features/post/presentation/widgets/post_button.dart';

// edited
class LikeButton extends StatefulWidget {
  final Post post;

  const LikeButton({super.key, required this.post});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late final UserEntity currUser;

  @override
  void initState() {
    super.initState();
    currUser = (context.read<AuthCubit>().state as Authenticated).user;
    context.read<LikeCubit>().track(currUser.id, widget.post);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikeCubit, LikeState>(
      builder: (context, state) {
        final isLiked = state.likedVideos[widget.post.id] ?? false;
        return PostButton(
          onTap:
              () => context.read<LikeCubit>().toggleLike(
                currUser.id,
                widget.post.id,
              ),
          icon: Icons.favorite,
          color: isLiked ? Colors.red : Colors.white,
          count: state.getDisplayLikeCount(widget.post.id),
        );
      },
    );
  }
}
