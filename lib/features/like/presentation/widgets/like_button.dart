import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  void initState() {
    super.initState();
    if (!widget.post.isViewed) {
      widget.post.markAsViewed();
      context.read<LikeCubit>().track(widget.post);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikeCubit, LikeState>(
      builder: (context, state) {
        final isLiked = state.likedVideos[widget.post.id] ?? false;
        return PostButton(
          onTap: () => context.read<LikeCubit>().toggleLike(widget.post.id),
          icon: Icons.favorite,
          color: isLiked ? Colors.red : Colors.white,
          count: state.getDisplayLikeCount(widget.post.id),
        );
      },
    );
  }
}
