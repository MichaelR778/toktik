import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/dependency_injection.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_state.dart';
import 'package:toktik/features/like/presentation/cubits/like_cubit.dart';
import 'package:toktik/features/post/domain/entities/post.dart';

class LikeButton extends StatelessWidget {
  final Post post;

  const LikeButton({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final currUser = (context.read<AuthCubit>().state as Authenticated).user;
    return BlocProvider(
      create: (context) => getIt<LikeCubit>()..init(post, currUser),
      child: BlocBuilder<LikeCubit, bool>(
        builder: (context, isLiked) {
          return IconButton(
            onPressed:
                () =>
                    context.read<LikeCubit>().toggleLike(currUser.id, post.id),
            icon: Icon(
              Icons.favorite,
              color: isLiked ? Colors.red : Colors.white,
            ),
          );
        },
      ),
    );
  }
}
