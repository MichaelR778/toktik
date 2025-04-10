import 'package:toktik/features/chat/domain/entities/message.dart';

abstract class MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<Message> messages;

  MessageLoaded({required this.messages});
}

class MessageError extends MessageState {
  final String message;

  MessageError({required this.message});
}
