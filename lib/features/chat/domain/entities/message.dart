class Message {
  final String senderId;
  final String content;
  final DateTime sentAt;

  Message({
    required this.senderId,
    required this.content,
    required this.sentAt,
  });
}
