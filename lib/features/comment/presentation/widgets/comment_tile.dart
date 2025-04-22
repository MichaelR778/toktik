import 'package:flutter/material.dart';
import 'package:toktik/features/comment/domain/entities/ui_comment.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';
import 'package:toktik/features/profile/presentation/widgets/profile_image.dart';

class CommentTile extends StatefulWidget {
  final UiComment uiComment;

  const CommentTile({super.key, required this.uiComment});

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  bool full = false;
  late final UserProfile profile;
  late final String text;

  @override
  void initState() {
    super.initState();
    profile = widget.uiComment.profile;
    text = widget.uiComment.comment.content;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileImage(imageUrl: profile.profileImageUrl, diameter: 50),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.username),

                // comment content
                LayoutBuilder(
                  builder: (context, constraints) {
                    final textPainter = TextPainter(
                      text: TextSpan(text: text),
                      textDirection: TextDirection.ltr,
                      maxLines: 3,
                    );
                    textPainter.layout(maxWidth: constraints.maxWidth);
                    final overflow = textPainter.didExceedMaxLines;

                    if (!overflow) return Text(text);

                    // text with see more button
                    return Column(
                      children: [
                        Text(
                          text,
                          overflow: full ? null : TextOverflow.ellipsis,
                          maxLines: full ? null : 3,
                        ),
                        if (!full)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                full = true;
                              });
                            },
                            child: Text(
                              'See more',
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
