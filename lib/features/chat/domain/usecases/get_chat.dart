import 'package:toktik/features/chat/domain/entities/chat.dart';
import 'package:toktik/features/chat/domain/repositories/chat_repository.dart';

class GetChat {
  final ChatRepository _chatRepository;

  GetChat({required ChatRepository chatRepository})
    : _chatRepository = chatRepository;

  Future<Chat?> call(String otherUserId) async {
    return await _chatRepository.getChat(otherUserId);
  }
}
