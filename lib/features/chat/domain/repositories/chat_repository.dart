import 'package:toktik/features/chat/domain/entities/chat.dart';
import 'package:toktik/features/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Future<Chat?> getChat(String otherUserId);
  Future<Chat> createChat(String otherUserId);
  Future<void> sendMessage(String chatId, String content);
  Stream<List<Message>> getMessageStream(String chatId);
  Stream<List<Chat>> getUserChatStream();
}
