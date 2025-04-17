import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toktik/features/chat/data/models/chat_model.dart';
import 'package:toktik/features/chat/data/models/message_model.dart';
import 'package:toktik/features/chat/domain/entities/chat.dart';
import 'package:toktik/features/chat/domain/entities/message.dart';
import 'package:toktik/features/chat/domain/repositories/chat_repository.dart';
import 'package:toktik/features/profile/data/models/user_profile_model.dart';
import 'package:toktik/features/profile/domain/entities/user_profile.dart';

class SupabaseChatRepository implements ChatRepository {
  final SupabaseClient _supabase;

  SupabaseChatRepository({required SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Future<Chat?> getChat(String otherUserId) async {
    try {
      // all chatIds where other user participate in
      final chatIdsRes = await _supabase
          .from('chat_participants')
          .select('chat_id')
          .eq('user_id', otherUserId);
      final chatIds =
          chatIdsRes.map((json) => json['chat_id'] as String).toList();

      // check if curr user has chat with this other user
      final currentUserId = _supabase.auth.currentUser!.id;
      final res =
          await _supabase
              .from('chat_participants')
              .select()
              .inFilter('chat_id', chatIds)
              .eq('user_id', currentUserId)
              .maybeSingle();
      if (res == null) return null;

      // get chatJson and return chatModel
      final chatId = res['chat_id'] as String;
      final chatJson =
          await _supabase.from('chats').select().eq('id', chatId).single();
      final otherUserProfile = await getOtherUserProfile(currentUserId, chatId);
      return ChatModel.fromJson({...chatJson, 'other_user': otherUserProfile});
    } catch (e) {
      throw 'Failed to check if chat exist: $e';
    }
  }

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
        .order('created_at', ascending: true)
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
        .stream(primaryKey: ['chat_id', 'user_id'])
        .eq('user_id', currentUserId)
        .asyncMap((data) async {
          final chatIds =
              data.map((json) => json['chat_id'] as String).toList();
          if (chatIds.isEmpty) return <Chat>[];

          // get user chats
          final chatJsons = await _supabase
              .from('chats')
              .select()
              .inFilter('id', chatIds)
              .order('last_message_at');

          // get other user profile for each chat
          return Future.wait(
            (chatJsons).map((chatJson) async {
              final otherUserProfile = await getOtherUserProfile(
                currentUserId,
                chatJson['id'],
              );
              return ChatModel.fromJson({
                ...chatJson,
                'other_user': otherUserProfile,
              });
            }),
          );
        });
  }

  // helper func to get other user profile from a chat
  Future<UserProfile> getOtherUserProfile(
    String currentUserId,
    String chatId,
  ) async {
    try {
      final otherUserIdQuery = await _supabase
          .from('chat_participants')
          .select('user_id')
          .eq('chat_id', chatId);
      final otherUserId =
          otherUserIdQuery.firstWhere(
                (data) => data['user_id'] != currentUserId,
              )['user_id']
              as String;
      final otherUserJson =
          await _supabase.from('users').select().eq('id', otherUserId).single();
      return UserProfileModel.fromJson(otherUserJson);
    } catch (e) {
      throw 'Failed to get other user profile: $e';
    }
  }
}
