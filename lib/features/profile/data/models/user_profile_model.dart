import 'package:toktik/features/profile/domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  UserProfileModel({
    required super.userId,
    required super.username,
    required super.profileImageUrl,
    required super.followers,
    required super.following,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['id'],
      username: json['username'],
      profileImageUrl: json['pfp_url'],
      followers:
          (json['followers'] as List<dynamic>)
              .map((userId) => userId as String)
              .toList(),
      following:
          (json['following'] as List<dynamic>)
              .map((userId) => userId as String)
              .toList(),
    );
  }
}
