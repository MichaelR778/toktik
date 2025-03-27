import 'package:toktik/features/post/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.id,
    required super.userId,
    required super.videoUrl,
  });

  factory PostModel.fromEntity(Post entity) {
    return PostModel(
      id: entity.id,
      userId: entity.userId,
      videoUrl: entity.videoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {'user_id': userId, 'video_url': videoUrl};
  }
}
