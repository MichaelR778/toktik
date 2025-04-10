import 'package:toktik/features/chat/domain/entities/chat.dart';

class ChatModel extends Chat {
  ChatModel({required super.id, required super.lastUpdated});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      lastUpdated: DateTime.parse(json['last_message_at']),
    );
  }
}
