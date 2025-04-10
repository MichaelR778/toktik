import 'package:toktik/features/chat/domain/entities/message.dart';
import 'package:toktik/features/chat/domain/repositories/chat_repository.dart';

class GetMessageStream {
  final ChatRepository _chatRepository;

  GetMessageStream({required ChatRepository chatRepository})
    : _chatRepository = chatRepository;

  Stream<List<Message>> call(String chatId) {
    return _chatRepository.getMessageStream(chatId);
  }
}
