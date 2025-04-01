import 'package:toktik/features/post/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.id,
    required super.userId,
    required super.videoUrl,
    required super.likes,
  });

  factory PostModel.fromEntity(Post entity) {
    return PostModel(
      id: entity.id,
      userId: entity.userId,
      videoUrl: entity.videoUrl,
      likes: entity.likes,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['user_id'],
      videoUrl: json['video_url'],
      likes: (json['likes'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'user_id': userId, 'video_url': videoUrl, 'likes': likes};
  }
}
