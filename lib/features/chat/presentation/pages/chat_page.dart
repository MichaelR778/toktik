import 'package:flutter/material.dart';
import 'package:toktik/features/chat/domain/entities/chat.dart';

class ChatPage extends StatelessWidget {
  final Chat chat;

  const ChatPage({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(chat.otherUserProfile.username)),
    );
  }
}
