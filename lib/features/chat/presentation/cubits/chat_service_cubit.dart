import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/chat/domain/usecases/create_chat.dart';
import 'package:toktik/features/chat/domain/usecases/send_message.dart';
import 'package:toktik/features/chat/presentation/cubits/chat_service_state.dart';

class ChatServiceCubit extends Cubit<ChatServiceState> {
  final CreateChat _createChatUsecase;
  final SendMessage _sendMessageUsecase;

  ChatServiceCubit({
    required CreateChat createChatUsecase,
    required SendMessage sendMessageUsecase,
  }) : _createChatUsecase = createChatUsecase,
       _sendMessageUsecase = sendMessageUsecase,
       super(ChatServiceInitial());

  Future<void> createChat(String otherUserId) async {
    try {
      await _createChatUsecase(otherUserId);
    } catch (e) {
      emit(ChatServiceError(message: e.toString()));
    }
  }

  Future<void> sendMessage(String chatId, String content) async {
    try {
      await _sendMessageUsecase(chatId, content);
    } catch (e) {
      emit(ChatServiceError(message: e.toString()));
    }
  }
}
