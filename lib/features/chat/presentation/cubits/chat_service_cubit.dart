import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/chat/domain/entities/chat.dart';
import 'package:toktik/features/chat/domain/usecases/create_chat.dart';
import 'package:toktik/features/chat/domain/usecases/get_chat.dart';
import 'package:toktik/features/chat/domain/usecases/send_message.dart';
import 'package:toktik/features/chat/presentation/cubits/chat_service_state.dart';

class ChatServiceCubit extends Cubit<ChatServiceState> {
  final GetChat _getChatUsecase;
  final CreateChat _createChatUsecase;
  final SendMessage _sendMessageUsecase;

  ChatServiceCubit({
    required GetChat getChatUsecase,
    required CreateChat createChatUsecase,
    required SendMessage sendMessageUsecase,
  }) : _getChatUsecase = getChatUsecase,
       _createChatUsecase = createChatUsecase,
       _sendMessageUsecase = sendMessageUsecase,
       super(ChatServiceInitial());

  Future<Chat?> getChat(String otherUserId) async {
    try {
      return await _getChatUsecase(otherUserId);
    } catch (e) {
      emit(ChatServiceError(message: e.toString()));
      return null;
    }
  }

  Future<Chat?> createChat(String otherUserId) async {
    try {
      return await _createChatUsecase(otherUserId);
    } catch (e) {
      emit(ChatServiceError(message: e.toString()));
      return null;
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
