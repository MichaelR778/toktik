import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/dependency_injection.dart';
import 'package:toktik/features/chat/domain/entities/chat.dart';
import 'package:toktik/features/chat/presentation/cubits/chat_service_cubit.dart';
import 'package:toktik/features/chat/presentation/cubits/message_cubit.dart';
import 'package:toktik/features/chat/presentation/cubits/message_state.dart';
import 'package:toktik/features/chat/presentation/widgets/message_bubble.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;

  const ChatPage({super.key, required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MessageCubit>()..init(widget.chat.id),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.chat.otherUserProfile.username)),
        body: BlocBuilder<MessageCubit, MessageState>(
          builder: (context, state) {
            // loading
            if (state is MessageLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            // loaded
            else if (state is MessageLoaded) {
              final messages = state.messages;
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return MessageBubble(message: messages[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 5);
                      },
                    ),
                  ),
                  // bottom offset for textfield
                  SizedBox(height: 100),
                ],
              );
            }

            // error etc
            return const Center(child: Text('Something went wrong'));
          },
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
                  context.read<ChatServiceCubit>().sendMessage(
                    widget.chat.id,
                    _controller.text,
                  );
                  _controller.clear();
                },
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
