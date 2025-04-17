import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:toktik/features/auth/presentation/cubits/auth_state.dart';
import 'package:toktik/features/chat/domain/entities/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final currUser = (context.read<AuthCubit>().state as Authenticated).user;
    final myMessage = currUser.id == message.senderId;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment:
          myMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: myMessage ? colorScheme.inversePrimary : colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: colorScheme.primary),
          ),
          child: Text(
            message.content,
            style: TextStyle(
              color:
                  myMessage ? colorScheme.primary : colorScheme.inversePrimary,
            ),
          ),
        ),
      ],
    );
  }
}
