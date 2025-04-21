import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/dependency_injection.dart';
import 'package:toktik/features/comment/domain/entities/ui_comment.dart';
import 'package:toktik/features/comment/presentation/cubits/comment_cubit.dart';
import 'package:toktik/features/comment/presentation/cubits/comment_state.dart';

class CommentSection extends StatelessWidget {
  final int postId;

  const CommentSection({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CommentCubit>()..fetchComment(postId),
      child: BlocBuilder<CommentCubit, CommentState>(
        builder: (context, state) {
          // loading
          if (state is CommentLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // loaded
          else if (state is CommentLoaded) {
            final uiComments = state.uiComments;
            return _CommentLoadedWidget(postId: postId, uiComments: uiComments);
          }

          // error etc
          return const Center(child: Text('Failed to load comments'));
        },
      ),
    );
  }
}

class _CommentLoadedWidget extends StatefulWidget {
  final int postId;
  final List<UiComment> uiComments;

  const _CommentLoadedWidget({required this.postId, required this.uiComments});

  @override
  State<_CommentLoadedWidget> createState() => __CommentLoadedWidgetState();
}

class __CommentLoadedWidgetState extends State<_CommentLoadedWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uiComments = widget.uiComments;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child:
                uiComments.isEmpty
                    ? const Center(child: Text('No comment yet'))
                    : ListView.builder(
                      itemCount: uiComments.length,
                      itemBuilder: (context, index) {
                        final uiComment = uiComments[index];
                        return ListTile(
                          title: Text(uiComment.profile.username),
                          subtitle: Text(uiComment.comment.content),
                        );
                      },
                    ),
          ),
          // bottom offset for textfield
          SizedBox(height: 100),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 100,
        child: Row(
          children: [
            Expanded(child: TextField(controller: _controller)),
            IconButton(
              onPressed: () {
                context.read<CommentCubit>().addComment(
                  widget.postId,
                  _controller.text,
                );
                _controller.clear();
              },
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}
