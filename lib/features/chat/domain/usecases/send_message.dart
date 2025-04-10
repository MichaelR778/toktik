import 'package:toktik/features/chat/domain/repositories/chat_repository.dart';

class SendMessage {
  final ChatRepository _chatRepository;

  SendMessage({required ChatRepository chatRepository})
    : _chatRepository = chatRepository;

  Future<void> call(String chatId, String content) async {
    if (content.isEmpty) return;
    return await _chatRepository.sendMessage(chatId, content);
  }
}
