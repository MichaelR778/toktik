import 'package:toktik/features/chat/domain/entities/chat.dart';
import 'package:toktik/features/chat/domain/repositories/chat_repository.dart';

class GetUserChatStream {
  final ChatRepository _chatRepository;

  GetUserChatStream({required ChatRepository chatRepository})
    : _chatRepository = chatRepository;

  Stream<List<Chat>> call() {
    return _chatRepository.getUserChatStream();
  }
}
