abstract class ChatServiceState {}

class ChatServiceInitial extends ChatServiceState {}

class ChatServiceError extends ChatServiceState {
  final String message;

  ChatServiceError({required this.message});
}
