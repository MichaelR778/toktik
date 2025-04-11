import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toktik/features/chat/data/models/chat_model.dart';
import 'package:toktik/features/chat/data/models/message_model.dart';
import 'package:toktik/features/chat/domain/entities/chat.dart';
import 'package:toktik/features/chat/domain/entities/message.dart';
import 'package:toktik/features/chat/domain/repositories/chat_repository.dart';
import 'package:toktik/features/profile/data/models/user_profile_model.dart';

class SupabaseChatRepository implements ChatRepository {
  final SupabaseClient _supabase;

  SupabaseChatRepository({required SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Future<Chat> createChat(String otherUserId) async {
    try {
      final currentUserId = _supabase.auth.currentUser!.id;

      // create chat
      final res = await _supabase.from('chats').insert({}).select().single();
      final chatId = res['id'] as String;

      // add participants
      await _supabase.from('chat_participants').insert([
        {'chat_id': chatId, 'user_id': currentUserId},
        {'chat_id': chatId, 'user_id': otherUserId},
      ]);

      final otherUserJson =
          await _supabase.from('users').select().eq('id', otherUserId).single();
      return ChatModel.fromJson({
        ...res,
        'other_user': UserProfileModel.fromJson(otherUserJson),
      });
    } catch (e) {
      throw 'Failed to create chat: $e';
    }
  }

  @override
  Future<void> sendMessage(String chatId, String content) async {
    try {
      final currentUserId = _supabase.auth.currentUser!.id;

      // send message
      await _supabase.from('messages').insert({
        'chat_id': chatId,
        'sender_id': currentUserId,
        'content': content,
      });

      // update chat last message timestamp
      await _supabase
          .from('chats')
          .update({'last_message_at': DateTime.now().toIso8601String()})
          .eq('id', chatId);
    } catch (e) {
      throw 'Failed to send message: $e';
    }
  }

  @override
  Stream<List<Message>> getMessageStream(String chatId) {
    return _supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatId)
        .order('created_at')
        .map(
          (data) =>
              data.map((msgJson) => MessageModel.fromJson(msgJson)).toList(),
        );
  }

  @override
  Stream<List<Chat>> getUserChatStream() {
    final currentUserId = _supabase.auth.currentUser?.id;
    if (currentUserId == null) {
      return Stream.error('User is not logged in');
    }

    return _supabase
        .from('chat_participants')
        .select('chat_id')
        .eq('user_id', currentUserId)
        .asStream()
        .asyncMap((data) async {
          // get user chats
          final chatIds =
              data.map((json) => json['chat_id'] as String).toList();
          final chatJsons = await _supabase
              .from('chats')
              .select()
              .inFilter('id', chatIds)
              .order('last_message_at');

          // get other user profile for each chat
          return Future.wait(
            (chatJsons).map((chatJson) async {
              final otherUserIdQuery = await _supabase
                  .from('chat_participants')
                  .select('user_id')
                  .eq('chat_id', chatJson['id']);
              final otherUserId =
                  otherUserIdQuery.firstWhere(
                        (data) => data['user_id'] != currentUserId,
                      )['user_id']
                      as String;
              final otherUserJson =
                  await _supabase
                      .from('users')
                      .select()
                      .eq('id', otherUserId)
                      .single();
              return ChatModel.fromJson({
                ...chatJson,
                'other_user': UserProfileModel.fromJson(otherUserJson),
              });
            }),
          );
        });
  }
}
