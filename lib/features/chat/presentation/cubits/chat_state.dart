import 'package:toktik/features/chat/domain/entities/chat.dart';

abstract class ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Chat> chats;

  ChatLoaded({required this.chats});
}

class ChatError extends ChatState {
  final String message;

  ChatError({required this.message});
}
