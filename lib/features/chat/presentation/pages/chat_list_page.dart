import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/core/widgets/user_tile.dart';
import 'package:toktik/features/chat/presentation/cubits/chat_cubit.dart';
import 'package:toktik/features/chat/presentation/cubits/chat_state.dart';
import 'package:toktik/features/chat/presentation/pages/chat_page.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatLoaded) {
            final chats = state.chats;
            if (chats.isEmpty) {
              return const Center(child: Text('No chat found'));
            }
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return UserTile(
                  profile: chat.otherUserProfile,
                  navigateTo: ChatPage(chat: chat),
                );
              },
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
