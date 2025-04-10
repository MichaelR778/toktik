import 'package:toktik/features/chat/domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required super.senderId,
    required super.content,
    required super.sentAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['sender_id'],
      content: json['content'],
      sentAt: DateTime.parse(json['created_at']),
    );
  }
}
